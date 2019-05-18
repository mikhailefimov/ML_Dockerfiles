# ML_Dockerfiles

This repository contains:
1. Dockerfiles and build scripts for Jupyter Notebook with NVIDIA GPU support and some ML specific libraries preinstallled.
2. Scripts to build Tensorflow 1.13.1 and PyTorch 1.1.0 python wheels from sources for GPUs with Compute Capability 3.0 in docker containers. (This is unofficial, so use at your own risk.)

PyTorch keeps issuing warnings on old GPU, but probably works (see also https://discuss.pytorch.org/t/pytorch-no-longer-supports-this-gpu-because-it-is-too-old/13803/32).

# Usage

#### Building custom wheels
1. Customize build options in files [tensorflow_whl/makeit.sh](tensorflow_whl/makeit.sh) and [torch_whl/makeit.sh](torch_whl/makeit.sh) if needed.
2. Execute `build.wheels.sh`
3. Wait.... I's very long process. May take some hours.
4. Hopefully new wheels will be in the folder `wheels`.

#### Building image with Jupyter Notebook
To build image with custom versions of Tensorflow and PyTorch execute `build.all.sh`.
It will use wheels from the folder `wheels`, if they exist.
Otherwise it will build new ones.

To build image with default tensorflow-gpu and pytorch from conda - execute `build.default.sh`. 

#### Starting Jupyter Notebook
Execute `start_jupyter.sh`. Current folder will be mounted to image as folder for notebooks.

Create symlink for start_jupyter.sh somewhere on PATH to start it from any folder.

## What's included
In final [emm/jupyter](jupyter/Dockerfile) image:
- Everything from [jupyter/scipy-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-scipy-notebook):
    - [Miniconda](https://conda.io/miniconda.html) Python 3.x, 
    - [Jupyter Notebook server](https://jupyter.org)
    - Common scientific packages (numpy, matplotlib, sklearn, pandas and many others)
    - [ipywidgets](https://ipywidgets.readthedocs.io/en/stable/) for interactive visualizations in Python notebooks
    - [Facets](https://github.com/PAIR-code/facets) for visualizing machine learning datasets
- CUDA libraries
- [Tensorflow](https://www.tensorflow.org/)
- [Tensorboard](https://www.tensorflow.org/guide/summaries_and_tensorboard) and [jupyter-tensorboard](https://pypi.org/project/jupyter-tensorboard/)
- [PyTorch](https://pytorch.org/) and torchvision
- OpenAI [gym](https://github.com/openai/gym), [roboschool](https://github.com/openai/roboschool), [retro] (https://github.com/openai/retro)
- [PyBullet](https://github.com/bulletphysics/bullet3/tree/master/examples/pybullet/gym/pybullet_envs) physics engine and gym environments
- Virtual display support for rendering on headless server.

To install additional conda or pip packages - use 

`!conda install -y <package>` 

or

`!pip install <package>`
 
To install OS packages (image is based on Ububtu 18.04) - use 

`!sudo apt-get install -y <package>`
 

## Intermediate Dockerfiles

 - [emm/cuda-base](cuda-base/Dockerfile) contains Python, Conda, Jupyter Notebook with come common libraries plus CUDA runtime libraries.  
 
 - [emm/cuda-dev](cuda-dev/Dockerfile) adds to [emm/cuda-base](cuda-base/Dockerfile) build-time CUDA-dev libraries. 
   It is used as common base to build custom wheels.  

 - [emm/tensorflow_whl](tensorflow_whl/Dockerfile) and [emm/torch_whl](torch_whl/Dockerfile) are temporary images,
   used only to build custom wheels for Tensorflow and Pytorch with support for  GPUs with Compute Capability 3.0  

## Prerequisites
To use these images host must have:
- [Nvidia-docker (version 2.0)](https://github.com/NVIDIA/nvidia-docker) and it's dependencies
- [NVIDIA drivers](http://www.nvidia.com) version 410.xx.
