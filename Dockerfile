# Use an official Tomcat image as the base
FROM tomcat:9.0-jdk11-openjdk

# Install Maven and other necessary tools
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY . .

# Build the Java application using Maven
RUN mvn package

# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file to the Tomcat webapps directory
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat and keep it running in the foreground
CMD ["catalina.sh", "run"]
