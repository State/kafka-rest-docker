#!/bin/bash

: ${KAFKA_REST_INSTANCE_ID}
: ${ADVERTISED_HOSTNAME}
: ${SCHEMA_REGISTRY_URL}
: ${ZOOKEEPER_URL}

cat >/etc/kafka-rest/kafka-rest.properties <<EOF
id=${KAFKA_REST_INSTANCE_ID:-1}
schema.registry.url=${SCHEMA_REGISTRY_URL:-http://localhost:8081}
zookeeper.connect=${ZOOKEEPER_URL-localhost:2181}
acks=all
EOF

if [[ -n ${ADVERTISED_HOSTNAME} ]]; then
  echo "host.name=${ADVERTISED_HOSTNAME}" >> /etc/kafka-rest/kafka-rest.properties
fi

exec ./bin/kafka-rest-start /etc/kafka-rest/kafka-rest.properties
