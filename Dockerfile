FROM openjdk:11
WORKDIR /build
COPY pom.xml .
COPY src src
RUN mvn clean package
FROM tomcat:latest
COPY --from=0 /build/target/MW-HelloWorld-Jar.jar webapps/
RUN chgrp -R 0 /usr/local/tomcat && chmod -R g=u /usr/local/tomcat
EXPOSE 8080

CMD ["catalina.sh", "run"]

ENTRYPOINT ["java","-jar","webapps/MW-HelloWorld-Jar.jar"]