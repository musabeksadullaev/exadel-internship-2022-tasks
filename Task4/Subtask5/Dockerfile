FROM maven:3.8.6-jdk-8 as build

ENV PASSWORD

WORKDIR /app

COPY ./src/ /app

RUN mvn install -DskipTests

RUN echo $PASSWORD

# ---------------------

FROM openjdk:8

WORKDIR /app

COPY --from=build /app/target/blog-api-docker.jar ./app.jar

ENTRYPOINT ["java", "-jar","/app/app.jar"]

EXPOSE 8080
