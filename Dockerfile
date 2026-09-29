FROM tomcat:9.0

RUN rm -rf /usr/local/tomcat/webapps/*

COPY web/target/time-tracker-web-0.5.0-SNAPSHOT.war \
     /usr/local/tomcat/webapps/time-tracker.war

EXPOSE 8080
