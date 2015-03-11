#!/bin/bash

: ${KAFKA_REST_INSTANCE_ID}
: ${ADVERTISED_HOSTNAME}
: ${SCHEMA_REGISTRY_URL}
: ${ZOOKEEPER_URL}

if [[ -n ${KAFKA_REST_INSTANCE_ID} ]]; then
  sed -e "s/id=.*/id=${KAFKA_REST_INSTANCE_ID}/" \
    -i /etc/kafka-rest/kafka-rest.properties
fi

if [[ -n ${ADVERTISED_HOSTNAME} ]]; then
  echo "host.name=${ADVERTISED_HOSTNAME}" >> /etc/kafka-rest/kafka-rest.properties
fi

if [[ -n ${SCHEMA_REGISTRY_URL} ]]; then
  sed -e "s/schema.registry.url=.*/schema.registry.url=${SCHEMA_REGISTRY_URL}/" \
    -i /etc/kafka-rest/kafka-rest.properties
fi

if [[ -n ${ZOOKEEPER_URL} ]]; then
  sed -e "s/zookeeper.connect=.*/zookeeper.connect=${ZOOKEEPER_URL}/" \
    -i /etc/kafka-rest/kafka-rest.properties
fi

exec ./bin/kafka-rest-start /etc/kafka-rest/kafka-rest.properties
