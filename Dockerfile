# Imagen base de Tomcat 9 con Java 11
FROM tomcat:9.0-jdk11

# Eliminamos la app por defecto
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copiamos JSPs y recursos
COPY ./web /usr/local/tomcat/webapps/ROOT

# Copiamos las clases compiladas generadas por NetBeans
COPY ./build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# Exponemos el puerto
EXPOSE 8080

# Iniciamos Tomcat
CMD ["catalina.sh", "run"]
