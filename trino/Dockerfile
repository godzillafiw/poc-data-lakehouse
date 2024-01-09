FROM trinodb/trino:406

ENV RANGER_VERSION 3.0.0-SNAPSHOT-trino-plugin-405-406
ENV RANGER_HOME /opt/ranger

WORKDIR ${RANGER_HOME}
USER root

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ranger-${RANGER_VERSION}.tar.gz /tmp

RUN mkdir -p ${RANGER_HOME}/ranger-${RANGER_VERSION} \
    && tar -zxvf /tmp/ranger-${RANGER_VERSION}.tar.gz -C ${RANGER_HOME}/ranger-${RANGER_VERSION} --strip-components 1 \
    && rm -rf /tmp/ranger-${RANGER_VERSION}.tar.gz

COPY ./conf/ranger/install.properties ${RANGER_HOME}/ranger-${RANGER_VERSION}
COPY ./conf/ranger/install.properties ${RANGER_HOME}
ADD run.sh /run.sh

CMD ["/run.sh"]