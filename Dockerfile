# Use Tomcat 10 with Java 11
FROM tomcat:10-jdk11

# Copy the WAR file to webapps
COPY target/PRJ301_YouTube-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
