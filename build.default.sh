#!/bin/bash

set -e

[[ -d wheels ]] || mkdir wheels

echo "BUILDING cuda-base"
docker build --rm -t emm/cuda-base ./cuda-base

echo
echo "BUILDING Jupyter"
rm -rf jupyter/wheels/*
docker build --rm -t emm/jupyter ./jupyter
