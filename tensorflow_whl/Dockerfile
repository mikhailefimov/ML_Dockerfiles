FROM emm/cuda-dev

RUN conda install Pillow h5py matplotlib mock numpy scipy scikit-learn pandas && \
    conda install -c conda-forge keras-applications keras-preprocessing && \
    conda clean -ya

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