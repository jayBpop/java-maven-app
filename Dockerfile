FROM openjdk:8
EXPOSE 8080
ADD /target/java-maven-app-*.jar java-maven-app-*.jar
# ENTRYPOINT ["java","-jar","/java-maven-app-1.1.0-SNAPSHOT.jar"]
CMD java -jar java-maven-app-*.jar