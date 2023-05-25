FROM tomcat:8.5.87-jre8

LABEL maintainer="gtrofimov@parasoft.com"
LABEL cam_version="1.2.1"

COPY cam.war /usr/local/tomcat/webapps

EXPOSE 8080

CMD ["catalina.sh","run"]