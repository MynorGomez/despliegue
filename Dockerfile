## Imagen base de Tomcat 9 con Java 11
FROM tomcat:9.0-jdk11

# Eliminamos la aplicación por defecto
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copiamos el archivo WAR generado por NetBeans
# (ajusta el nombre del .war según el que esté en tu carpeta dist/)
COPY ./dist/Sistema.war /usr/local/tomcat/webapps/Sistema.war

# Exponemos el puerto 8080
EXPOSE 8080

# Iniciamos Tomcat
CMD ["catalina.sh", "run"]

