FROM ubuntu:latest
RUN apt-get update && \
    apt-get upgrade -y && \
    export DEBIAN_FRONTEND=noninteractive && \
    ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
    apt-get install git maven tomcat9 openjdk-11-jdk -y && \
    apt-get clean
RUN mkdir /tmp/build && \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /tmp/build/ && \
    mvn package -f /tmp/build/ && \
    cp /tmp/build/target/hello-1.0.war /var/lib/tomcat9/webapps/ && \
    rm -rf /tmp/build 
ENV CATALINA_BASE=/var/lib/tomcat9
EXPOSE 8080
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]
