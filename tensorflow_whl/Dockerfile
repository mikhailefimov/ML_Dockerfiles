FROM emm/miniconda3

RUN apt-get update && apt-get install -y --no-install-recommends \
        libcudnn7-dev=${CUDNN_VERSION}-1+cuda10.0 \
        libcurl3-dev \
        rsync \
        zip \
        && \
    find /usr/local/cuda-10.0/lib64/ -type f -name 'lib*_static.a' -not -name 'libcudart_static.a' -delete && \
    rm /usr/lib/x86_64-linux-gnu/libcudnn_static_v7.a && \
    apt-get update \
    && apt-get install -y --no-install-recommends libnvinfer-dev=5.0.2-1+cuda10.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    python3-dev \
    swig

# Install bazel
ARG BAZEL_VERSION=0.19.2
RUN mkdir /bazel && \
    wget -O /bazel/installer.sh "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh" && \
    wget -O /bazel/LICENSE.txt "https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE" && \
    chmod +x /bazel/installer.sh && \
    /bazel/installer.sh && \
    rm -f /bazel/installer.sh

# Some TF tools expect a "python" binary
RUN ln -s $(which python3) /usr/local/bin/python

WORKDIR /tensorflow
RUN git clone https://github.com/tensorflow/tensorflow.git /tensorflow && \
    git checkout -b tmp v1.13.1

COPY *.sh /root/
RUN chmod a+x /root/*.sh

CMD [ "/bin/bash" ]