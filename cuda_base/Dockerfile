FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        software-properties-common \
        unzip \
        wget \
        curl \
        git \
        nvinfer-runtime-trt-repo-ubuntu1804-5.0.2-ga-cuda10.0 && \
    apt-get update && \
    apt-get install -y --no-install-recommends libnvinfer5=5.0.2-1+cuda10.0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/include/x86_64-linux-gnu/cudnn_v7.h /usr/local/cuda/include/cudnn_v7.h && \
    ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.7 /usr/local/cuda/lib64/libcudnn.so.7

ENV CUDA_HOME /usr/local/cuda
ENV LD_LIBRARY_PATH $CUDA_HOME/extras/CUPTI/lib64:$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH
ENV CUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so.7

CMD [ "/bin/bash" ]