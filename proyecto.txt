# Imagen base de Tomcat 9 con Java 11
FROM tomcat:9.0-jdk11

# Eliminamos la app por defecto
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copiamos el contenido de la carpeta 'web' (JSP, HTML, etc.)
COPY ./web /usr/local/tomcat/webapps/ROOT

# Copiamos las clases compiladas (NetBeans las guarda en build/classes)
COPY ./build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# Exponemos el puerto 8080
EXPOSE 8080

# Iniciamos Tomcat
CMD ["catalina.sh", "run"]
