#!/bin/bash

RANGER_VERSION=3.0.0-SNAPSHOT-trino-plugin-405-406
RANGER_HOME=/opt/ranger

# yes | cp -rf ${RANGER_HOME}/install.properties ${RANGER_HOME}/ranger-${RANGER_VERSION} \
${RANGER_HOME}/ranger-${RANGER_VERSION}/enable-trino-plugin.sh \
&& /usr/lib/trino/bin/run-trino
