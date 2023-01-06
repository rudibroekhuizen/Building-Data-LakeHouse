#!/bin/bash

set -eux -o pipefail

mc alias set biocloud http://localhost:9000 admin 123456789
mc admin service restart biocloud

mc mb biocloud/deltalake
