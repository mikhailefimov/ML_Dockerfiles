FROM emm/cuda-dev

RUN conda install -y numpy pyyaml scipy ipython mkl mkl-include cython && \
    conda install -y -c pytorch magma-cuda100 && \
    conda clean -ya && \
    pip install ninja && \
    apt-get update && apt-get install -y --no-install-recommends cmake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /opt && \
    git clone --recursive https://github.com/pytorch/pytorch && cd pytorch && \
    git checkout -b tmp v1.1.0 && \
    git submodule update --init

COPY *.sh /root/
RUN chmod a+x /root/*.sh

CMD [ "/bin/bash" ]