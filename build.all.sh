#!/bin/bash

set -e

[[ -d wheels ]] || mkdir wheels

echo "BUILDING cuda-base"
docker build --rm -t emm/cuda-base ./cuda-base

echo
echo "BUILDING cuda-dev"
docker build --rm -t emm/cuda-dev ./cuda-dev

echo
if [ ! -f wheels/torch*.whl ]; then
    echo "BUILDING PyTorch wheel"
    docker build --rm -t emm/torch_whl ./torch_whl
    docker run --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" --name emm.build_torch_whl emm/torch_whl /root/makeit.sh
    docker rm emm.build_torch_whl
    docker image rm emm/torch_whl
else
    echo "FOUND PyTorch wheel, skipping"
fi

echo
if [ ! -f wheels/tensorflow*.whl ]; then
    echo "BUILDING Tensoflow wheel"
    docker build --rm -t emm/tensorflow_whl ./tensorflow_whl
    docker run --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" --name emm.build_tf_whl emm/tensorflow_whl /root/makeit.sh
    docker run --rm --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" emm/tensorflow_whl /root/testit.sh
    docker rm emm.build_tf_whl
    docker image rm emm/tensorflow_whl
else
    echo "FOUND Tensoflow wheel, skipping"
fi

echo
echo "BUILDING Jupyter"
cp -r wheels jupyter
docker build --rm -t emm/jupyter ./jupyter
rm -rf jupyter/wheels/*.whl