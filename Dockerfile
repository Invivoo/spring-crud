FROM maven:3-openjdk-17-slim as build

RUN mkdir -p /workspace

WORKDIR /workspace

COPY pom.xml /workspace

COPY src /workspace/src

RUN mvn -f pom.xml clean package



FROM alpine/java:17-jdk

COPY --from=build /workspace/target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT [ "java", "-jar", "/app.jar" ]


# Step 1: Use an official OpenJDK base image from Docker Hub
#FROM alpine/java:17-jdk

# Step 2: Set the working directory inside the container
#WORKDIR /app

# Step 3: Copy the Spring Boot JAR file into the container
#COPY target/spring-postgres-crud-0.0.1-SNAPSHOT.jar /app/spring-postgres-crud-0.0.1-SNAPSHOT.jar
#COPY src/main/resources/application.yml /config/application.yml

#ENV SPRING_CONFIG_LOCATION=classpath:/,file:/config/
# Step 4: Expose the port your application runs on
#EXPOSE 8081

# Step 5: Define the command to run your Spring Boot application
# CMD ["java", "-jar", "/app/spring-postgres-crud-0.0.1-SNAPSHOT.jar", "--spring.config.location=/config/application.yml"]

#ENTRYPOINT ["java","-jar","/app/spring-postgres-crud-0.0.1-SNAPSHOT.jar"]