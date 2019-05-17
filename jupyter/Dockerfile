FROM jupyter/scipy-notebook

USER root

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
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        software-properties-common \
        unzip \
        wget \
        git \
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
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID

COPY tensorflow*.whl /home/$NB_USER/
#install dependencies first
RUN pip --no-cache-dir install --upgrade pip setuptools && \
    conda uninstall matplotlib && \
    conda update conda && \
    conda update --all && \
    conda clean -ya && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN conda install mkl six && \
    pip install --no-cache-dir ninja && \
    conda install -y -c pytorch magma-cuda100 && \
    conda clean -ya && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN conda install protobuf  grpcio astor gast absl-py termcolor markdown werkzeug matplotlib numpy pyyaml scipy mkl mkl-include cython typing \
        tensorflow-estimator==1.13.0 \
        tensorboard==1.13.1 && \
    conda install -c conda-forge keras-applications keras-preprocessing && \
    conda clean -ya && \
    pip install  --no-cache-dir /home/$NB_USER/tensorflow*.whl && \
    echo "tensorflow-gpu ==1.13.1" >> /opt/conda/conda-meta/pinned && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    rm -f /home/$NB_USER/tensorflow*.whl

COPY torch-*.whl /home/$NB_USER/
RUN pip install --no-cache-dir /home/$NB_USER/torch-*.whl && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    rm -f /home/$NB_USER/torch-*.whl

RUN pip install --no-cache-dir torchvision && \
    pip install --no-cache-dir jupyter-tensorboard && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN jupyter tensorboard enable --sys-prefix

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-dev zlib1g-dev libjpeg-dev cmake swig python-pyglet python3-opengl libboost-all-dev libsdl2-dev \
        libosmesa6-dev patchelf ffmpeg xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

#    freeglut3-dev

USER $NB_UID

RUN conda install -y -c conda-forge pyglet pyopengl pyvirtualdisplay && \
    conda clean -ya && \
    pip --no-cache-dir install gym[atari,box2d,classic_control] && \
    rm -rf /var/lib/apt/lists/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
