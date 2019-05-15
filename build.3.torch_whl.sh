#!/bin/bash

set -e

[[ -d wheels ]] || mkdir wheels

docker build --rm -t emm/torch_whl ./torch_whl
docker run --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" emm/torch_whl /root/makeit.sh