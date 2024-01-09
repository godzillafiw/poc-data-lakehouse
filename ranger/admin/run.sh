#!/bin/bash

RANGER_VERSION=2.1.0
RANGER_HOME=/opt/ranger-admin

cd ${RANGER_HOME}
./setup.sh && \
ranger-admin start && \
tail -f ${RANGER_HOME}/ews/logs/ranger-admin-*-.log
