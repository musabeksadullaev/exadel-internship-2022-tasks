FROM maven:3.8.6-jdk-8 as build

ENV PASSWORD default_password

WORKDIR /app

COPY ./src/ /app

RUN mvn install -DskipTests

# ---------------------

FROM openjdk:8

WORKDIR /app

COPY --from=build /app/target/blog-api-docker.jar ./app.jar

CMD echo $PASSWORD

ENTRYPOINT ["java", "-jar","/app/app.jar"]

EXPOSE 8080
