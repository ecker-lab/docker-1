# Usage

The most recent version of this image is available at Docker hub automatically
(by automated builds from this repo). Thus, you do not have to build the image
locally anymore.

Start a CPU container exposing Jupyter lab to port 9999 on the host machine:
```bash
dockerrun --env-file path_to_env_file -p 9999:8888 maxfburg/base:latest
```
Passing an environment file is optional. Possible to pass more arguments.

Start a container on GPU 0 exposing Jupyter lab to port 9999 on the host machine:
```bash
GPU=0 dockerrun --env-file path_to_env_file maxfburg/base:latest
```

Show list of running containers and assigned GPU:
```bash
dockerps
```

Get an interactive shell in the container:
```bash
dockerexec container-id /bin/bash
```



## Build and use image locally

Build the Docker image locally:
```bash
docker build . -t your-image-tag
```
The commands above stay the same, just replace the standard image tag 
```maxfburg/base:latest``` by the tag you specified above, ```your-image-tag```.



# Contributing

Please contribute by opening a pull request.



# Acknowledgements

Matthias Kümmerer (https://github.com/matthias-k) for helpful discussions.