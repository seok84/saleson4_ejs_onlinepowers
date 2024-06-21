FROM tomcat:10.1.17-jdk21-temurin-jammy

VOLUME /root

ARG TOMCAT_DIR=/usr/local/tomcat
ARG ANT_DIR=/usr/local/ant
ARG WAR_FILE=./build/libs/saleson-front-jsp-*-plain.war

ENV TZ="Asia/Seoul"
ENV JAVA_OPTS="-Dspring.profiles.active=production-docker"

RUN apt-get update && apt-get -y install unzip

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN rm -rf ${TOMCAT_DIR}/webapps/*
RUN mkdir ${TOMCAT_DIR}/webapps/ROOT

RUN rm -rf ${TOMCAT_DIR}/work/*
RUN mkdir ${TOMCAT_DIR}/work/Catalina
RUN mkdir ${TOMCAT_DIR}/work/Catalina/localhost
RUN mkdir ${TOMCAT_DIR}/work/Catalina/localhost/ROOT

RUN mkdir /root/logs
RUN mkdir /static
RUN mkdir /license
RUN mkdir /temp
RUN mkdir ${ANT_DIR}

COPY .docker/ant ${ANT_DIR}
COPY .docker/conf ${TOMCAT_DIR}/conf
#COPY ./static/content /static/content
COPY .docker/license /license
COPY ${WAR_FILE} ${TOMCAT_DIR}/saleson4.war

# RUN echo "<meta charset='utf-8'><h1>$(date)</h1>" > /static/content/update.html
RUN unzip ${TOMCAT_DIR}/saleson4.war -d ${TOMCAT_DIR}/webapps/ROOT
RUN rm -rf ${TOMCAT_DIR}/saleson4.war

RUN ${TOMCAT_DIR}/conf/ant-build.sh

CMD ["catalina.sh", "run", "-Dspring.profiles.active=production-docker"]