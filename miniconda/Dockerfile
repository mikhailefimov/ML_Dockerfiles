FROM emm/cuda_base

ENV PATH /opt/conda/bin:$PATH

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN pip --no-cache-dir install --upgrade pip setuptools && \
    conda update conda && \
    conda update --all && \
    conda install Pillow h5py matplotlib mock numpy scipy scikit-learn pandas && \
    conda install -c conda-forge keras-applications keras-preprocessing && \
    conda clean -ya

CMD [ "/bin/bash" ]