ARG BASE_CONTAINER=jupyter/base-notebook:python-3.8.5
FROM $BASE_CONTAINER

LABEL maintainer="Max Burg <max.burg@bethgelab.org>"


# switch to root for installing software
USER root


# ---- install NVIDIA libraries -----

# The following code block is adapted from
# https://gitlab.com/nvidia/container-images/cuda and
# https://hub.docker.com/layers/nvidia/cuda/11.0-cudnn8-devel-ubuntu18.04/images/sha256-11777cee30f0bbd7cb4a3da562fdd0926adb2af02069dad7cf2e339ec1dad036?context=explore 
# under the following license:

# Copyright (c) 2019,2020 NVIDIA CORPORATION. All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


RUN apt-get update && apt-get install -y --no-install-recommends     gnupg2 curl ca-certificates &&     curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - &&     echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list &&     echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list &&     apt-get purge --autoremove -y curl     && rm -rf /var/lib/apt/lists/* 
ENV CUDA_VERSION=11.0.3
RUN apt-get update && apt-get install -y --no-install-recommends     cuda-cudart-11-0=11.0.221-1     cuda-compat-11-0     && ln -s cuda-11.0 /usr/local/cuda &&     rm -rf /var/lib/apt/lists/*
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf &&     echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV NVIDIA_REQUIRE_CUDA=cuda>=11.0 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 brand=tesla,driver>=450,driver<451
ENV NCCL_VERSION=2.7.8
RUN apt-get update && apt-get install -y --no-install-recommends     cuda-libraries-11-0=11.0.3-1     libnpp-11-0=11.1.0.245-1     cuda-nvtx-11-0=11.0.167-1     libcublas-11-0=11.2.0.252-1     libnccl2=$NCCL_VERSION-1+cuda11.0     && apt-mark hold libnccl2     && rm -rf /var/lib/apt/lists/*
ENV NCCL_VERSION=2.7.8
RUN apt-get update && apt-get install -y --no-install-recommends     cuda-nvml-dev-11-0=11.0.167-1     cuda-command-line-tools-11-0=11.0.3-1     cuda-nvprof-11-0=11.0.221-1     libnpp-dev-11-0=11.1.0.245-1     cuda-libraries-dev-11-0=11.0.3-1     cuda-minimal-build-11-0=11.0.3-1     libnccl-dev=2.7.8-1+cuda11.0     libcublas-dev-11-0=11.2.0.252-1     libcusparse-11-0=11.1.1.245-1     libcusparse-dev-11-0=11.1.1.245-1     && apt-mark hold libnccl-dev     && rm -rf /var/lib/apt/lists/*
ENV LIBRARY_PATH=/usr/local/cuda/lib64/stubs
ENV CUDNN_VERSION=8.0.4.30
RUN apt-get update && apt-get install -y --no-install-recommends     libcudnn8=$CUDNN_VERSION-1+cuda11.0     libcudnn8-dev=$CUDNN_VERSION-1+cuda11.0     && apt-mark hold libcudnn8 &&     rm -rf /var/lib/apt/lists/*


# ---- install apt packages -----

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq -qq --no-install-recommends \
  g++ \
  git \
  htop \
  imagemagick \
  less \
  libgmp-dev \
  liboctave-dev \
  make \
  octave \
  octave-image \
  octave-statistics \
  python3-dev \
  unzip \
  vim \
  zlib1g \
  zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# ---- install python packages -----

RUN conda install \
        # jupyter_nbextensions_configurator \
        boltons>=20.1.0\
        bs4 \ 
        click \
        corner \
        cython \
        dill \
        emcee \
        executor \
        fastprogress \
        flask \
        glom \
	gunicorn \
        h5py \
        hypothesis \
        imageio \
        ipyparallel \
        ipywidgets \
        jsonschema \
        line_profiler \
        natsort \
        numba \
        pandas \
        pdvega \
        pillow \
        pixiedust \
        psutil \
        pytest \
        requests \
        schema \
        seaborn \
        scikit-learn \
        tqdm \
        wand \
        webargs>=6.0.0 \
        xonsh \
        gitpython \
        scikit-image \
 && conda clean -tipsy \
 && fix-permissions $CONDA_DIR \
 && fix-permissions /home/$NB_USER

RUN pip install --no-cache-dir tensorflow-gpu \
 && fix-permissions $CONDA_DIR \
 && fix-permissions /home/$NB_USER

RUN pip install --no-cache-dir torch==1.5.0+cu101 torchvision==0.6.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html \
 && fix-permissions $CONDA_DIR \
 && fix-permissions /home/$NB_USER

RUN pip install --no-cache-dir datajoint==0.12.4 \
 && fix-permissions $CONDA_DIR \
 && fix-permissions /home/$NB_USER

RUN rm /usr/bin/python3 && ln -s /opt/conda/bin/python


# switch back to default user (jovyan)
USER $NB_USER