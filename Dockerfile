# Use Gradle with JDK 17 for building the project
FROM gradle:7.5-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

# Use OpenJDK 17 for running the application
FROM openjdk:17-jre-slim
COPY --from=build /home/gradle/src/build/libs/*.jar /app/your-app.jar
ENTRYPOINT ["java", "-jar", "/app/your-app.jar"]
