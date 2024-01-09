FROM openjdk:8u342-jre

RUN apt-get update \
 && apt-get install --assume-yes python3 python3-pip procps \
 && apt-get clean

RUN pip3 install pyspark~=3.3.1 pandas~=1.5.3

RUN apt-get update \
 && apt-get install --assume-yes telnet \
 && apt-get clean

WORKDIR /opt

ENV HADOOP_VERSION=3.2.4
ENV METASTORE_VERSION=3.0.0

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

RUN mkdir -p ${HIVE_HOME} ${HADOOP_HOME} \
    && cd /opt

RUN wget https://downloads.apache.org/hive/hive-standalone-metastore-${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz \
    && tar -zxvf /opt/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz  \
    && rm -rf /opt/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz

RUN wget https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -zxvf /opt/hadoop-${HADOOP_VERSION}.tar.gz  \
    && rm -rf /opt/hadoop-${HADOOP_VERSION}.tar.gz

RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz \
    && tar -zxvf /opt/mysql-connector-java-8.0.19.tar.gz \
    && cp /opt/mysql-connector-java-8.0.19/mysql-connector-java-8.0.19.jar ${HIVE_HOME}/lib/ \
    && rm -rf  /opt/mysql-connector-java-8.0.19


COPY metastore-site.xml ${HIVE_HOME}/conf
COPY run.sh /run.sh

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /run.sh && chmod +x /run.sh

ENV PATH="${HADOOP_HOME}:${PATH}"
ENV PATH="${HIVE_HOME}:${PATH}"

USER hive
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/run.sh"]