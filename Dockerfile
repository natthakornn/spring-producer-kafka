FROM eclipse-temurin:21-jdk-jammy AS builder

ADD . .

RUN ./gradlew build -x test

FROM eclipse-temurin:21-jre-jammy
USER root

WORKDIR /opt/app-root

COPY --from=builder build/docker /opt/app-root

ENTRYPOINT [ "java", "-jar", "spring-producer-kafka.jar" ]