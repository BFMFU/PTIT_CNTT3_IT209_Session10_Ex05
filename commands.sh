#!/bin/sh
set -eu


POSTGRES_USER="${POSTGRES_USER:-app}"
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-postgres}"
POSTGRES_DB="${POSTGRES_DB:-appdb}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

docker build --tag hello-backend:latest "$SCRIPT_DIR/Hello"

if ! docker network inspect app-net >/dev/null 2>&1; then
  docker network create app-net
fi

if ! docker volume inspect db-data >/dev/null 2>&1; then
  docker volume create db-data
fi

if docker container inspect backend-server >/dev/null 2>&1; then
  docker rm -f backend-server
fi

if docker container inspect db-server >/dev/null 2>&1; then
  docker rm -f db-server
fi

docker run -d \
  --name db-server \
  --network app-net \
  -e POSTGRES_USER="$POSTGRES_USER" \
  -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
  -e POSTGRES_DB="$POSTGRES_DB" \
  -v db-data:/var/lib/postgresql/data \
  postgres:15-alpine

wait_for_db() {
  attempt=0
  until docker exec db-server pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" >/dev/null 2>&1; do
    attempt=$((attempt + 1))
    if [ "$attempt" -ge 30 ]; then
      echo "PostgreSQL did not become ready within 30 seconds." >&2
      docker logs db-server >&2
      exit 1
    fi
    sleep 1
  done
}

wait_for_db

docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" db-server \
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -v ON_ERROR_STOP=1 \
  -c "CREATE TABLE IF NOT EXISTS persistence_check (id INTEGER PRIMARY KEY, marker TEXT NOT NULL);" \
  -c "INSERT INTO persistence_check (id, marker) VALUES (1, 'data-survived-recreation') ON CONFLICT (id) DO NOTHING;"

docker rm -f db-server

docker run -d \
  --name db-server \
  --network app-net \
  -e POSTGRES_USER="$POSTGRES_USER" \
  -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
  -e POSTGRES_DB="$POSTGRES_DB" \
  -v db-data:/var/lib/postgresql/data \
  postgres:15-alpine

wait_for_db

persisted_marker=$(docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" db-server \
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -Atqc \
  "SELECT marker FROM persistence_check WHERE id = 1;")
if [ "$persisted_marker" != "data-survived-recreation" ]; then
  echo "Persistence check failed: expected marker was not found in db-data." >&2
  exit 1
fi
echo "Persistence check passed: $persisted_marker"

docker run -d \
  --name backend-server \
  --network app-net \
  -p 3000:3000 \
  -e DB_HOST=db-server \
  -e DB_PORT=5432 \
  -e DB_NAME="$POSTGRES_DB" \
  -e DB_USER="$POSTGRES_USER" \
  -e DB_PASSWORD="$POSTGRES_PASSWORD" \
  hello-backend:latest

docker exec backend-server ping -c 2 db-server
