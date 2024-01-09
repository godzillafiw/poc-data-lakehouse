FROM centos:centos7 as base

RUN yum update -y \
    && yum -y install vim wget rpm-build which tar git gcc java-1.8.0-openjdk-devel \
    && yum clean all -y

ENV JAVA_HOME /usr/lib/jvm/java-openjdk
ENV RANGER_HOME /opt/ranger-admin
ENV MAVEN_HOME /opt/maven
ENV RANGER_VERSION 2.1.0
ENV MAVEN_VERSION 3.6.3

ENV MAVEN_OPTS "-Xmx2048m -XX:MaxMetaspaceSize=512m"
ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir $MAVEN_HOME \
    && export http_proxy=$http_proxy \
    && wget -P $MAVEN_HOME https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/$MAVEN_VERSION/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    && tar -xzvf $MAVEN_HOME/apache-maven-$MAVEN_VERSION-bin.tar.gz -C $MAVEN_HOME \
    && rm -f $MAVEN_HOME/apache-maven-$MAVEN_VERSION-bin.tar.gz

WORKDIR ${RANGER_HOME}

ADD https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-${RANGER_VERSION}-admin.tar.gz /tmp

RUN tar -zxvf /tmp/ranger-${RANGER_VERSION}-admin.tar.gz -C ${RANGER_HOME} --strip-components 1 \
    && rm -rf /tmp/ranger-${RANGER_VERSION}-admin.tar.gz

FROM base

ENV MYSQL_CONNECTOR_JAVA_VERSION 5.1.41
ENV POSTGRES_CONNECTOR_JAVA_VERSION 42.2.23

RUN yum update -y \
    && yum -y install mysql \
    && yum clean all -y

RUN wget -P /opt https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_CONNECTOR_JAVA_VERSION.tar.gz \
    && tar -zxvf /opt/mysql-connector-java-$MYSQL_CONNECTOR_JAVA_VERSION.tar.gz -C /opt \
    && rm -f /opt/mysql-connector-java-$MYSQL_CONNECTOR_JAVA_VERSION.tar.gz \
    && ln -s /opt/mysql-connector-java-$MYSQL_CONNECTOR_JAVA_VERSION/mysql-connector-java-$MYSQL_CONNECTOR_JAVA_VERSION-bin.jar /opt/mysql-connector-java.jar

RUN wget -O /opt/postgresql.jar https://jdbc.postgresql.org/download/postgresql-$POSTGRES_CONNECTOR_JAVA_VERSION.jar

COPY install.properties ${RANGER_HOME}

ADD run.sh /run.sh

CMD ["/run.sh"]