#!/bin/bash

set -e

[[ -d wheels ]] || mkdir wheels

echo "BUILDING cuda_base"
docker build --rm -t emm/cuda_base ./cuda_base

echo
echo "BUILDING miniconda"
docker build --rm -t emm/miniconda3 ./miniconda

echo
if [ ! -f wheels/torch*.whl ]; then
    echo "BUILDING PyTorch wheel"
    docker build --rm -t emm/torch_whl ./torch_whl
    docker run --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" emm/torch_whl /root/makeit.sh
else
    echo "FOUND PyTorch wheel, skipping"
fi

echo
if [ ! -f wheels/tensorflow*.whl ]; then
    echo "BUILDING Tensoflow wheel"
    docker build --rm -t emm/tensorflow_whl ./tensorflow_whl
    docker run --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" emm/tensorflow_whl /root/makeit.sh
    docker run --rm --runtime=nvidia -it -v $PWD/wheels:/mnt -e HOST_PERMS="$(id -u):$(id -g)" emm/tensorflow_whl /root/testit.sh
else
    echo "FOUND Tensoflow wheel, skipping"
fi

echo
echo "BUILDING Jupyter"
cp wheels/*.whl jupyter
docker build --rm -t emm/jupyter ./jupyter
rm jupyter/*.whl