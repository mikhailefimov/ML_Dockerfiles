#!/bin/bash

set -e

[[ -d wheels ]] || mkdir wheels

docker build --rm -t emm/tensorflow_whl ./tensorflow_whl
docker run --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" emm/tensorflow_whl /root/makeit.sh
docker run --rm --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" emm/tensorflow_whl /root/testit.sh
