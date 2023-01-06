#!/bin/bash

set -eux -o pipefail

mc alias set deltalake http://localhost:9000 admin 123456789
mc admin service restart deltalake

mc mb deltalake/biocloud
