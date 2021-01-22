# Usage

The most recent version of this image is available at Docker hub by automated 
builds from the main branch of this repo.

Start a CPU container exposing Jupyter lab to port 9999 on the host machine:
```bash
dockerrun --env-file path_to_env_file -p 9999:8888 maxfburg/base:latest
```
Passing an environment file is optional. Possible to pass more arguments.

Start a container on GPU 0 exposing Jupyter lab to port 9999 on the host machine:
```bash
GPU=0 dockerrun --env-file path_to_env_file -p 9999:8888 maxfburg/base:latest
```

Start container as above and run python script right after startup:
```bash
GPU=0 dockerrun --env-file path_to_env_file maxfburg/base:latest start.sh python3 my-script.py
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

In case you want to build the Docker image locally:
```bash
docker build . -t your-image-tag
```
The commands above stay the same, just replace the standard image tag 
```maxfburg/base:latest``` by the tag you specified above, ```your-image-tag```.



# Contributing

Please contribute by opening a pull request.



# Acknowledgements

Matthias Kümmerer (https://github.com/matthias-k) for helpful discussions.
