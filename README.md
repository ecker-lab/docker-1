# Usage

Versions of this image for various combinations of CUDA, Python, PyTorch, Tensorflow, and Jupyter Lab are available at Docker Hub (https://hub.docker.com/repository/docker/eckerlabdocker/docker).

Start a CPU container exposing Jupyter lab to a random port on the host machine:
```bash
dockerrun --env-file <path_to_env_file> <image_name>
```
where `<image_name>` has to be replaced by the image you want to use, e.g. `eckerlabdocker/docker:cuda11.0-py3.8-torch1.7-tf2.4`. Passing an environment file is optional. Dockerrun sets a random Jupyter Lab portforwarding automatically. You can overwrite this behaviour by passing `--jupyterport PORTNUMBER`. Additionally, you can pass any argument that would work with standard `docker run`.

Start a container from image `<image_name>` on GPU 0 exposing Jupyter lab to port 9999 on the host machine:
```bash
GPU=0 dockerrun --env-file <path_to_env_file> --jupyterport 9999 <image_name>
```
To start a container using multiple GPUs, pass the GPU numbers comma separated, e.g. `GPU=0,1,2`.

Start container as above and run python script right after startup:
```bash
GPU=0 dockerrun --env-file <path_to_env_file> <image_name> start.sh python3 my-script.py
```

If you do not specify `JUPYTER_TOKEN` by setting it and passing the env file, the standard value `JUPYTER_TOKEN=please_set_individual_token` is set automatically.

Show list of running containers and assigned GPU:
```bash
dockerps
```

Get an interactive shell in the container:
```bash
dockerexec <container_id> /bin/bash
```



## Build and use image locally

In case you want to build the Docker image locally:
```bash
docker build -t <your_image_tag> <path_to_dockerfile>
```
You can use your local image as outlined above.



# Contributing

Please contribute by opening a pull request. 


## Ecker lab members

If you want to upgrade the CUDA, Python or Jupyter Lab version, pull the according commit from https://github.com/jupyter/docker-stacks into our fork (https://github.com/ecker-lab/docker-stacks). Modify the Dockerfile in base-notebook to derive from the nvidia image with the desired CUDA version (e.g. nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04). Please use a LTS release of Ubuntu. If you need to use a Python version newer than the one provided by Jupyter Docker Stacks, modify the Dockerfile accordingly. Then, build the image locally and push it to https://hub.docker.com/r/eckerlabdocker/docker-stacks with a tag following the usual naming scheme. Commit and push the according Dockerfile to this repo's main branch, tagging it with the same tag that you used for the Docker image on Docker Hub (`git tag -a tagname -m "Commit message"` and `git push --tag`).

If you want to upgrade packages such as PyTorch, Tensorflow or DataJoint, modify the Dockerimage in this repo and push it - tagged with the usual naming scheme - to https://hub.docker.com/repository/docker/eckerlabdocker/docker. Also, commit and push the according Dockerfile to this repo's main branch, tagging it with the same tag that you used for the Docker image on Docker Hub.




# Acknowledgements

Matthias Kümmerer (https://github.com/matthias-k) for helpful discussions starting this project.
