FROM emm/miniconda3

RUN mkdir /notebooks && chmod -R a+rwx /notebooks
WORKDIR /notebooks

EXPOSE 8888

RUN conda install jupyter && \
    python -m ipykernel.kernelspec && \
    conda clean -ya

COPY tensorflow*.whl /tmp/
#install dependencies first
RUN conda install \
        protobuf \
        grpcio \
        astor \
        gast \
        absl-py \
        termcolor \
        markdown \
        werkzeug \
        tensorflow-estimator==1.13.0 \
        tensorboard==1.13.1 && \
    conda clean -ya && \
    pip install  --no-cache-dir /tmp/tensorflow*.whl && \
    rm -f /tmp/tensorflow*.whl && \
    echo "tensorflow-gpu ==1.13.1" >> /opt/conda/conda-meta/pinned

COPY torch-*.whl /tmp/
RUN pip install --no-cache-dir /tmp/torch-*.whl && \
    rm -f /tmp/torch-*.whl

RUN pip install --no-cache-dir torchvision
RUN pip install --no-cache-dir jupyter-tensorboard

CMD ["bash", "-c", "jupyter notebook --notebook-dir=/notebooks --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token=''"]
