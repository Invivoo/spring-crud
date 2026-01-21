# 1 ére methode
FROM maven:3-openjdk-17-slim as build

RUN mkdir -p /app

WORKDIR /app

COPY pom.xml /app

COPY src /app/src

RUN mvn -f pom.xml clean package


FROM alpine/java:17-jdk

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT [ "java", "-jar", "/app.jar" ]

# 2 eme methode
#FROM alpine/java:17-jdk

#WORKDIR /app

#ADD target/spring-crud-0.0.1-SNAPSHOT.jar /app/app.jar

#EXPOSE 8081

#ENTRYPOINT ["java", "-jar", "app.jar"]