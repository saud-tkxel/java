# Use the official Maven image to build the app
FROM maven:3.8.6-openjdk-18-slim AS build
WORKDIR /app

# Copy the source code to the container
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use an OpenJDK runtime to run the app
FROM openjdk:18-jdk-slim
WORKDIR /app

# Copy the packaged application to the new image
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080 and set the entry point
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
