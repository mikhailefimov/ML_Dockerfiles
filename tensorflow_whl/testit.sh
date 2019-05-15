#!/bin/bash
pip install /mnt/tensorflow*.whl
cd /tmp
python -c "import tensorflow as tf; print(tf.contrib.eager.num_gpus())"
