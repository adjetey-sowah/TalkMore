FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install -y openjdk-21-jdk maven
COPY . .

RUN mvn clean package -DskipTests

FROM openjdk:21-slim

COPY --from=build /target/SilentWhisperer.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]