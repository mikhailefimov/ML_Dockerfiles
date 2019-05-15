# ML_Dockerfiles

These scripts build Tensorflow 1.3.1 and PyTorch 1.1.0 from sources for GPUs with Compute Capability 3.0 and install them to Docker container with Jupyter Notebook.

This is unofficial, so use at your own risk.

PyTorch keeps issuing warnings but probably works (see also https://discuss.pytorch.org/t/pytorch-no-longer-supports-this-gpu-because-it-is-too-old/13803/32).


## Prerequisites
[Nvidia-docker (version 2.0)](https://github.com/NVIDIA/nvidia-docker) and it's dependencies 
(Linux, Docker and NVIDIA drivers).

## Usage
* Script [build.1.cuda_base.sh](build.1.cuda_base.sh) builds image [emm/cuda_base](cuda_base/Dockerfile).
It is based on nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04 and prepares a reusable common environment for other images in this repository.

* Script [build.2.miniconda.sh](build.2.miniconda.sh) builds image [emm/miniconda3](miniconda/Dockerfile).
It is based on [emm/cuda_base](cuda_base/Dockerfile) and adds Python, Conda, and some common dependencies.

* Script [build.3.tensorflow_whl.sh](build.3.tensorflow_whl.sh) builds image [emm/tensorflow_whl](tensorflow_whl/Dockerfile)
and uses it to build Tensorflow wheel in folder `wheels`. This may take a lot of time (hours). 
Image emm/tensorflow_whl is based on emm/miniconda3 and may be deleted after executing the script.
The script keeps image and container for postmortem analysis in case of failure.

* Script [build.3.torch_whl.sh](build.3.torch_whl.sh) builds image [emm/torch_whl](torch_whl/Dockerfile)
and uses it to build PyTorch wheel in folder `wheels`. 
Image emm/torch_whl is based on emm/miniconda3 and may be deleted after executing script.
The script keeps image and container for postmortem analysis in case of failure.

* Script [build.4.jupyter.sh](build.4.jupyter.sh) builds image [emm/jupyter](jupyter/Dockerfile).
It is based on emm/miniconda3, adds Tensorflow and PyTorch wheels, configures Jupyter Notebook server.

* Script [build.all.sh](build.all.sh) is equal to the execution of all above scripts in sequence. 
It also checks the `wheels` folder and skips building wheels if they already exist.

* Script [start_jupyter.sh](start_jupyter.sh) may be used to run Jupyter Notebook server in the current folder (add it to PATH to run from anywhere).

