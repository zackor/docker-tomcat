FROM centos
MAINTAINER xugz@bjrrtx.com

ENV VERSION=8.5.39
RUN yum install java-1.8.0-openjdk wget curl unzip iproute net-tools -y && yum clean all && rm -rf /var/cache/yum/*
RUN wget http://mirrors.shu.edu.cn/apache/tomcat/tomcat-8/v${VERSION}/bin/apache-tomcat-${VERSION}.tar.gz \
 && tar zxf apache-tomcat-${VERSION}.tar.gz \
 && mv apache-tomcat-${VERSION} /usr/local/tomcat \
 && rm -rf apache-tomcat-${VERSION}.tar.gz /usr/local/tomcat/webapps/*  \
 && mkdir /usr/local/tomcat/webapps/test  \
 && echo "ok" > /usr/local/tomcat/webapps/test/status.html  \
 && sed -i '1a JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom $JAVA_OPTS"' /usr/local/tomcat/bin/catalina.sh  \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV PATH $PATH:/usr/local/tomcat/bin

WORKDIR /usr/local/tomcat
EXPOSE 8080
CMD ["catalina.sh" "run"]
