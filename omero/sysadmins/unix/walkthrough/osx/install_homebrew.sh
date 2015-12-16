#!/bin/bash

set -e -u -x

bash -eux step01_deps.sh
bash -eux step02_omero.sh
bash -eux step03_nginx.sh
bash -eux step04_test.sh
