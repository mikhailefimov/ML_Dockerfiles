#!/bin/bash

if [ -f /home/$NB_USER/wheels/tensorflow*.whl ]; then
    conda install tensorflow-estimator==1.13.0 tensorboard==1.13.1
    pip install --no-cache-dir /home/$NB_USER/wheels/tensorflow*.whl
    echo "tensorflow-gpu ==1.13.1" >> /opt/conda/conda-meta/pinned
else
    conda install tensorflow-gpu tensorboard
fi

if [ -f /home/$NB_USER/wheels/torch-*.whl ]; then
    pip install --no-cache-dir /home/$NB_USER/wheels/torch-*.whl
else
    conda install -c pytorch pytorch
fi