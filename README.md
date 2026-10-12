# Spring Boot CRUD Application with PostgreSQL/MySQL

This project is a Spring Boot application that demonstrates CRUD (Create, Read, Update, Delete) operations with PostgreSQL as the database and implements global exception handling.

## Features

- Create, Read, Update, Delete operations for an entity (e.g., `Employee`)
- PostgreSQL as the database
- Global exception handling with custom error responses
- RESTful API with Spring Boot
- Maven build

## Technologies Used

- Spring Boot 3.x
- Spring Data JPA
- PostgreSQL ou Mysql
- Maven
- Java 17
- Lombok (optional for reducing boilerplate code)

## Prerequisites

- Java 17 or higher
- PostgreSQL
- Maven
- Postman or cURL (for testing API)

## Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/Invivoo/spring-crud.git
cd spring-crud
```
### Step 2: Configure PostgreSQL Database
Ensure PostgreSQL/MySQL is installed and running. Create a new database and update the application.yml file with your database credentials:

```bash
# src/main/resources/application.yml
server:
  port: 8081
spring:
  application:
    name: spring-crud
  datasource:
      url: jdbc:mysql://${DB_HOST}/${DB_NAME}?useSSL=false
      username: ${DB_USERNAME}
      password: ${DB_PASSWORD}
  jpa:
    hibernate:
      ddl-auto: update
    properties:
      hibernate:
        dialect: org.hibernate.dialect.MySQLDialect
```
### Step 3: Build and Run the Application
```bash
mvn clean install
mvn spring-boot:run (add .env variables for local test )
```
```csharp

### Using docker + kuberenets
- install docker : https://docs.docker.com/engine/install/
- install minikube : https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download
```
### build spring-crud image
- docker build . -f Dockerfile -t repo(docker-hub)/spring-crud:{version}
- docker push repo(docker-hub)/spring-crud:{version}
```
### use minikube : cd k8s/
- minikube start --driver=docker
- eval $(minikube docker-env) if using local docker repo
- kubectl apply -f backend-app.yml
   -- deployment created 
   -- service created 
- kubectl apply -f mysql-db.yml
   -- deployment created 
   -- service created 
```
```
 - minikube dashboard 
 - minikube service <name> --url 
```
### redeploy spring-crud updated version
```
edit your code
relaunch docker build / + push the new version 
kubectl set image deployment/spring-crud-deployment spring-k8s-crud=(repo(docker-hub)/spring-crud:{new-version}
kubectl rollout status deployment/spring-crud-deployment
```

## Docker

The `Dockerfile` is a multi-stage build (Maven build, then a slim JRE image running as a non-root user).
The server listens on `$PORT` (default `8081`).

```bash
docker build -t spring-crud .
docker run -p 8081:8081 -e DB_HOST=<host:port> -e DB_NAME=<db> -e DB_USERNAME=<user> -e DB_PASSWORD=<pwd> spring-crud
```

Database settings: `DB_VENDOR` (`mysql` by default, or `postgresql`), `DB_HOST`, `DB_NAME`, `DB_USERNAME`, `DB_PASSWORD`, and optional `DB_PARAMS` (default `?useSSL=false`).

Local app + PostgreSQL with docker-compose (needs `POSTGRESDB_*` and `SPRING_*` variables in `.env`):

```bash
docker compose up --build
```

## Deploy on Render

1. Push the repository to GitHub.
2. In Render, choose **New > Blueprint** and select the repository; Render reads `render.yaml`.
3. It creates a PostgreSQL database (`spring-crud-db`) and a Docker web service wired to it through `DB_*` variables. Render injects `PORT`, which the app uses.

For a manual setup, create a Web Service with runtime **Docker** and set `DB_VENDOR=postgresql`, `DB_PARAMS=` (empty), `DB_HOST`, `DB_NAME`, `DB_USERNAME`, `DB_PASSWORD` from your Render PostgreSQL instance.
