# Use an official OpenJDK runtime as a parent image
FROM adoptopenjdk/openjdk8:latest

RUN apt-get update && apt-get install -y maven

WORKDIR /app

COPY . /app

RUN mvn clean package -X -DskipTests

CMD ["java","-jar","target/trail-0.0.1-SNAPSHOT.jar"]