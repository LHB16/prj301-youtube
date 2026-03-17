# Stage 1: Build WAR file bằng Maven
FROM maven:3.8-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Deploy lên Tomcat
FROM tomcat:10-jdk11
COPY --from=build /app/target/PRJ301_YouTube-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
