FROM emm/cuda-base

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        software-properties-common \
        unzip \
        wget \
        git \
        python3-dev zlib1g-dev libjpeg-dev cmake swig python-pyglet python3-opengl libboost-all-dev libsdl2-dev \
        freeglut3-dev libosmesa6-dev patchelf ffmpeg xvfb \
         && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


USER $NB_UID

#install dependencies
RUN conda install \
        protobuf \
        mock \
        grpcio \
        astor \
        gast \
        absl-py \
        termcolor \
        markdown \
        werkzeug \
        matplotlib \
        numpy \
        pyyaml \
        scipy \
        six \
        mkl \
        mkl-include \
        cython \
        && \
    conda install -c conda-forge \
        keras-applications \
        keras-preprocessing \
        pyglet \
        pyopengl \
        pyvirtualdisplay \
        && \
    pip install --no-cache-dir ninja && \
    conda install -y -c pytorch magma-cuda100 && \
    conda clean -ya && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

COPY wheels/ /home/$NB_USER/wheels/
COPY install_wheels.sh /home/$NB_USER/
RUN chmod a+rwx /home/$NB_USER/install_wheels.sh && chmod -R a+rwx /home/$NB_USER/wheels

USER $NB_UID

RUN /home/$NB_USER/install_wheels.sh && \
    rm -rf /home/$NB_USER/wheels && \
    rm -f /home/$NB_USER/install_wheels.sh  && \
    conda clean -ya && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN pip install --no-cache-dir torchvision && \
    pip install --no-cache-dir jupyter-tensorboard && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    jupyter tensorboard enable --sys-prefix

RUN pip --no-cache-dir install gym[atari,box2d,classic_control] roboschool gym-retro pybullet && \
    rm -rf /var/lib/apt/lists/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN conda install -y \
        catboost \
        && \
    conda clean -ya && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
