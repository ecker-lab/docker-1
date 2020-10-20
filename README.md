# Usage

Build the Docker image:
```bash
docker build . -t your-image-tag
```

Start a CPU container:
```bash
dockerrun --env-file path_to_env_file your-image-tag
```
Passing an environment file is optional. Possible to pass more arguments.

Start a container on GPU 0:
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



# Acknowledgements

Matthias Kümmerer (https://github.com/matthias-k) for helpful discussions.