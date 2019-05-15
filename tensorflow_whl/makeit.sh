#!/bin/bash

export TF_CUDA_VERSION=10.0
export TF_CUDNN_VERSION=7

# Settings for ./configure
export TF_CUDA_COMPUTE_CAPABILITIES=3.0
export CC_OPT_FLAGS='-march=native -Wno-sign-compare'
export TF_SET_ANDROID_WORKSPACE=0

export TF_NEED_CUDA=1
export TF_NEED_TENSORRT=1
export TF_NEED_OPENCL_SYCL=0
export TF_NEED_ROCM=0
export TF_CUDA_CLANG=0
export TF_NEED_MPI=0
export TF_ENABLE_XLA=0

export PYTHON_BIN_PATH=/usr/local/bin/python
export USE_DEFAULT_PYTHON_LIB_PATH=1
export GCC_HOST_COMPILER_PATH=/usr/bin/gcc
export CUDA_TOOLKIT_PATH=${CUDA_HOME}
export CUDNN_INSTALL_PATH=${CUDA_HOME}
export TENSORRT_INSTALL_PATH=/usr/lib/x86_64-linux-gnu
export TMP=/tmp

# checkout requested version
cd /tensorflow
git checkout -b tmp v1.13.1

# build
cat /dev/null | ./configure
bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp
chown $HOST_PERMS /tmp/tensorflow*.whl
cp --remove-destination /tmp/tensorflow*.whl /mnt
