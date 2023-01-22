FROM tomcat:latest
COPY /target/soc-capstone-bookstore.war  /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh","run"]
