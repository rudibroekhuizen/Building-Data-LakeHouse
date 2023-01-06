#!/bin/bash
set -euo pipefail

echo -e "Build containers..."
docker build -t presto:0.272.1 ./Dockerfiles/presto
docker build -t cluster-apache-spark:3.1.1 Dockerfiles/spark

echo -e "Start project..."
docker compose up -d

echo -e "Setup Minio"
docker compose exec minio bash '/opt/scripts/setup.sh'

