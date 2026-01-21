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
    url: jdbc:postgresql://localhost:3306/testdb?useSSL=false
    username: root
    password: root
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
mvn spring-boot:run
```
```csharp

### Using docker + kuberenets
- install docker : https://docs.docker.com/engine/install/
- instamm minikube : https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download
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
 - minikube service name --url 
```
### redeploy spring-crud updated version
```
edit your code
relaunch docker build / + push the new version 
kubectl set image deployment/spring-crud-deployment spring-k8s-crud=(repo(docker-hub)/spring-crud:{new-version}
kubectl rollout status deployment/spring-crud-deployment
```