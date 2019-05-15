#!/bin/bash

export CUDA_HOME=/usr/local/cuda
export TORCH_CUDA_ARCH_LIST="3.0"
export TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
export CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
cd /opt/pytorch
python setup.py bdist_wheel
chown $HOST_PERMS /opt/pytorch/dist/*.whl
cp --remove-destination /opt/pytorch/dist/*.whl /mnt
