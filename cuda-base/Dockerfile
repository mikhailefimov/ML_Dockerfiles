FROM jupyter/scipy-notebook

USER root


########################################################################################
# NVIDIA CUDA (based on bare Ubuntu 18.04)
########################################################################################

ENV CUDA_VERSION 10.0.130
ENV CUDA_PKG_VERSION 10-0=$CUDA_VERSION-1
ENV NCCL_VERSION 2.4.2
ENV CUDNN_VERSION 7.5.1.10

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.0 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=410,driver<411"

ENV CUDA_HOME /usr/local/cuda
ENV LD_LIBRARY_PATH $CUDA_HOME/extras/CUPTI/lib64:$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH
ENV PATH $CUDA_HOME/bin:${PATH}

ENV CUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so.7

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gnupg2 \
        curl \
        ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        cuda-cudart-$CUDA_PKG_VERSION \
        cuda-compat-10-0 \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-nvtx-$CUDA_PKG_VERSION \
        libnccl2=$NCCL_VERSION-1+cuda10.0 \
        libcudnn7=$CUDNN_VERSION-1+cuda10.0 \
        nvinfer-runtime-trt-repo-ubuntu1804-5.0.2-ga-cuda10.0 && \
    apt-mark hold libcudnn7 && \
    apt-mark hold libnccl2 && \
    ln -s cuda-10.0 /usr/local/cuda && \
    apt-get update && \
    apt-get install -y --no-install-recommends libnvinfer5=5.0.2-1+cuda10.0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
########################################################################################
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID

RUN pip --no-cache-dir install --upgrade pip setuptools && \
    conda uninstall matplotlib && \
    conda update conda && \
    conda update --all && \
    conda clean -ya && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


CMD [ "/bin/bash" ]