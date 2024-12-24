FROM openjdk:11-jre-slim
COPY ../target/myapp-1.0-SNAPSHOT.jar /app/myapp.jar
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]

