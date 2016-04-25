#!/usr/bin/env bash

sudo docker run -d -v $PWD/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus
sudo docker run -d -i -p 3000:3000 -e "GF_AUTH_BASIC_ENABLED=false" -e "GF_AUTH_ANONYMOUS_ENABLED=true" -e "GF_AUTH_ANONYMOUS_ORG_ROLE=Admin" grafana/grafana

curl -XPOST -i http://localhost:3000/api/datasources --data-binary @./grafana/create-data-source.json -H "Content-Type: application/json"
curl -XPOST -i http://localhost:3000/api/dashboards/db --data-binary @./grafana/trivial-dash.json -H "Content-Type: application/json"
