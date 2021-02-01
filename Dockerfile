ARG BASE_CONTAINER=eckerlabdocker/docker-stacks:cuda10.0-cudnn7-python3.7
FROM $BASE_CONTAINER

LABEL maintainer="Max Burg <max.burg@bethgelab.org>"


# switch to root for installing software
USER root


# ---- install apt packages -----

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq -qq --no-install-recommends \
  git \
  htop \
  make \
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
        fastprogress \
	gitpython \
        h5py \
        ipyparallel \
        ipywidgets \
        jsonschema \
	numpy \
        pandas \
        pillow \
        seaborn \
        scikit-learn \
        scikit-image \
	scipy \
	tensorboard \
	tqdm \
	pytorch==1.2.0 torchvision==0.4.0 cudatoolkit=10.0 -c pytorch \
 && conda clean -tipsy \
 && fix-permissions $CONDA_DIR \
 && fix-permissions /home/$NB_USER

RUN pip install --no-cache-dir tensorflow-gpu \
 && fix-permissions $CONDA_DIR \
 && fix-permissions /home/$NB_USER

RUN pip install --no-cache-dir datajoint==0.12.4 \
 && fix-permissions $CONDA_DIR \
 && fix-permissions /home/$NB_USER

RUN rm /usr/bin/python3 && ln -s /opt/conda/bin/python


# switch back to default user (jovyan)
USER $NB_USER

