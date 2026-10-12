PS D:\IT209\Session10\Ex05> docker compose up -d
WARN[0000] The "DB_NAME" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_USER" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PORT" variable is not set. Defaulting to a blank string. 
WARN[0000] The "PORT" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_USER" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_NAME" variable is not set. Defaulting to a blank string. 
[+] Building 66.7s (18/18) FINISHED                                                                                                                                                                
 => [internal] load local bake definitions                                                                                                                                                    0.0s
 => => reading from stdin 517B                                                                                                                                                                0.0s
 => [internal] load build definition from Dockerfile                                                                                                                                          0.0s
 => => transferring dockerfile: 443B                                                                                                                                                          0.0s
 => [internal] load metadata for docker.io/library/eclipse-temurin:21-jre                                                                                                                     1.5s
 => [internal] load metadata for docker.io/library/gradle:9.7.1-jdk21                                                                                                                         1.5s
 => [auth] library/gradle:pull token for registry-1.docker.io                                                                                                                                 0.0s
 => [auth] library/eclipse-temurin:pull token for registry-1.docker.io                                                                                                                        0.0s
 => [internal] load .dockerignore                                                                                                                                                             0.0s
 => => transferring context: 75B                                                                                                                                                              0.0s
 => [build 1/4] FROM docker.io/library/gradle:9.7.1-jdk21@sha256:3695cd3c4b617ccb7b351ff1481c0f141c5e87a89872dc8ca1e5a8eeac6a85e3                                                             0.0s
 => => resolve docker.io/library/gradle:9.7.1-jdk21@sha256:3695cd3c4b617ccb7b351ff1481c0f141c5e87a89872dc8ca1e5a8eeac6a85e3                                                                   0.0s
 => [stage-1 1/4] FROM docker.io/library/eclipse-temurin:21-jre@sha256:cff19e6215689161eb6162c11b86b0c60ddf802164f2eaf48d570f8fb79a36c5                                                       0.0s
 => => resolve docker.io/library/eclipse-temurin:21-jre@sha256:cff19e6215689161eb6162c11b86b0c60ddf802164f2eaf48d570f8fb79a36c5                                                               0.0s
 => [internal] load build context                                                                                                                                                             0.0s
 => => transferring context: 2.75kB                                                                                                                                                           0.0s
 => CACHED [build 2/4] WORKDIR /workspace                                                                                                                                                     0.0s
 => [build 3/4] COPY . .                                                                                                                                                                      0.0s
 => [build 4/4] RUN ./gradlew --no-daemon bootJar                                                                                                                                            63.8s
 => CACHED [stage-1 2/4] WORKDIR /app                                                                                                                                                         0.0s 
 => CACHED [stage-1 3/4] RUN apt-get update     && apt-get install -y --no-install-recommends iputils-ping     && rm -rf /var/lib/apt/lists/*                                                 0.0s 
 => CACHED [stage-1 4/4] COPY --from=build /workspace/build/libs/Hello-0.0.1-SNAPSHOT.jar app.jar                                                                                             0.0s 
 => exporting to image                                                                                                                                                                        0.4s 
 => => exporting layers                                                                                                                                                                       0.0s 
 => => exporting manifest sha256:b4791a50f6aa1dece78102f6fc0a64ce207356a8632ac6903e0cdf532d845c13                                                                                             0.0s 
 => => exporting config sha256:f8e3a377263cde87c4ead607d3a8fd0467537b1266b8e10ab7ba714168e2121c                                                                                               0.1s
 => => exporting attestation manifest sha256:61cf97435669ade8541b60a36a51165b9767ae18067282e48984f371721e2100                                                                                 0.1s
 => => exporting manifest list sha256:03ff896d85d50bf29f2d373855f085596c48ed8c42a35d6abc2c193fe55be840                                                                                        0.0s
 => => naming to docker.io/library/ex05-backend:latest                                                                                                                                        0.0s
 => => unpacking to docker.io/library/ex05-backend:latest                                                                                                                                     0.0s
 => resolving provenance for metadata file                                                                                                                                                    0.1s
[+] up 5/5
 ✔ Image ex05-backend        Built                                                                                                                                                            67.0s
 ✔ Network ex05_backend-net  Created                                                                                                                                                           0.0s
 ✔ Volume ex05_pgdata        Created                                                                                                                                                           0.0s
 ✔ Container ex05-database-1 Started                                                                                                                                                           1.5s
 ✔ Container ex05-backend-1  Started                                                                                                                                                           0.9s
PS D:\IT209\Session10\Ex05> docker compose ps
WARN[0000] The "DB_NAME" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_USER" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PORT" variable is not set. Defaulting to a blank string. 
WARN[0000] The "PORT" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_NAME" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_USER" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string. 
NAME             IMAGE          COMMAND                  SERVICE   CREATED          STATUS          PORTS
ex05-backend-1   ex05-backend   "java -jar /app/app.…"   backend   20 seconds ago   Up 20 seconds   0.0.0.0:56875->3000/tcp, [::]:56875->3000/tcp
PS D:\IT209\Session10\Ex05> docker compose logs -f
WARN[0000] The "DB_NAME" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_USER" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PORT" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_NAME" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_USER" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string. 
WARN[0000] The "PORT" variable is not set. Defaulting to a blank string. 
backend-1   | 
database-1  | Error: Database is uninitialized and superuser password is not specified.
backend-1   |   .   ____          _            __ _ _
backend-1   |  /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
backend-1   | ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
backend-1   |  \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
backend-1   |   '  |____| .__|_| |_|_| |_\__, | / / / /
backend-1   |  =========|_|==============|___/=/_/_/_/
backend-1   | 
backend-1   |  :: Spring Boot ::                (v4.1.1)
backend-1   | 
database-1  |        You must specify POSTGRES_PASSWORD to a non-empty value for the
backend-1   | 2026-10-12T11:02:45.813Z  INFO 1 --- [Hello] [           main] ra.edu.hello.HelloApplication            : Starting HelloApplication v0.0.1-SNAPSHOT using Java 21.0.12.1 with PID 1 (/app/app.jar started by root in /app)
database-1  |        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".
database-1  | 
backend-1   | 2026-10-12T11:02:45.818Z  INFO 1 --- [Hello] [           main] ra.edu.hello.HelloApplication            : No active profile set, falling back to 1 default profile: "default"
backend-1   | 2026-10-12T11:02:46.753Z  INFO 1 --- [Hello] [           main] o.s.boot.tomcat.TomcatWebServer          : Tomcat initialized with port 3000 (http)
backend-1   | 2026-10-12T11:02:46.764Z  INFO 1 --- [Hello] [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
backend-1   | 2026-10-12T11:02:46.764Z  INFO 1 --- [Hello] [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/11.0.24]
backend-1   | 2026-10-12T11:02:46.785Z  INFO 1 --- [Hello] [           main] b.w.c.s.WebApplicationContextInitializer : Root WebApplicationContext: initialization completed in 892 ms
backend-1   | 2026-10-12T11:02:47.079Z  INFO 1 --- [Hello] [           main] o.s.boot.tomcat.TomcatWebServer          : Tomcat started on port 3000 (http) with context path '/'
backend-1   | 2026-10-12T11:02:47.088Z  INFO 1 --- [Hello] [           main] ra.edu.hello.HelloApplication            : Started HelloApplication in 1.682 seconds (process running for 2.243)
database-1  |        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
database-1  |        connections without a password. This is *not* recommended.
database-1  | 
database-1  |        See PostgreSQL documentation about "trust":
database-1  |        https://www.postgresql.org/docs/current/auth-trust.html

PS D:\IT209\Session10\Ex05> docker compose down
WARN[0000] The "DB_NAME" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_USER" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PORT" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_NAME" variable is not set. Defaulting to a blank string. 
WARN[0000] The "DB_USER" variable is not set. Defaulting to a blank string. 
WARN[0000] The "PORT" variable is not set. Defaulting to a blank string. 
[+] down 3/3
 ✔ Container ex05-backend-1  Removed                                                                                                                                                           0.3s
 ✔ Container ex05-database-1 Removed                                                                                                                                                           0.0s
 ✔ Network ex05_backend-net  Removed                                                                                                                                                           0.2s
PS D:\IT209\Session10\Ex05> 