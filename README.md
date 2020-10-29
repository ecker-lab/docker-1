# Usage

Build the Docker image:
```bash
docker build . -t your-image-tag
```

Start a CPU container exposing Jupyter lab to port 9999 on the host machine:
```bash
dockerrun --env-file path_to_env_file -p 9999:8888 your-image-tag
```
Passing an environment file is optional. Possible to pass more arguments.

Start a container on GPU 0 exposing Jupyter lab to port 9999 on the host machine:
```bash
GPU=0 dockerrun --env-file path_to_env_file your-image-tag
```

Show list of running containers and assigned GPU:
```bash
dockerps
```

Get an interactive shell in the container:
```bash
dockerexec container-id /bin/bash
```



# Contributing

Please contribute by opening a pull request.



# Acknowledgements

Matthias Kümmerer (https://github.com/matthias-k) for helpful discussions.