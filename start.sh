#!/bin/bash
set -euo pipefail

echo -e "Build containers..."
docker build -t cluster-apache-spark:3.1.1 Dockerfiles/spark
docker build -t presto:0.272.1 ./Dockerfiles/presto

echo -e "Start project..."
docker compose up -d

echo -e "Setup Minio..."
docker compose exec minio bash '/opt/scripts/setup.sh'

echo -e "Install jar files needed for our spark project.."
docker exec -it master bash /opt/workspace/dependencies/packages_installer.sh 

