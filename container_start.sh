#!/bin/bash 

# ls /usr/users/agecker # > /dev/null

# NV_GPU=$GPU docker run --rm -it --gpus all --user root -p 8888:8888 --name "`whoami`$GPU-`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`" -e NB_UID=`id -u` -e NB_GID=47162 -e NB_USER=$USER -e GRANT_SUDO=yes -e USER=`whoami` -e GPU=$GPU -e JUPYTER_ENABLE_LAB=yes max-test
# NV_GPU=$GPU docker run --rm -it --gpus all --user root -p 8888:8888 --name "`whoami`$GPU-`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`" -e NB_UID=`id -u` -e NB_GID=47162 -e NB_USER=$USER -e GRANT_SUDO=yes -e USER=`whoami` -e GPU=$GPU -e JUPYTER_ENABLE_LAB=yes -v /usr/users/`whoami`:/home/`whoami` max-test
# NV_GPU=$GPU docker run --rm -it --gpus all --user root -p 8888:8888 --name "`whoami`$GPU-`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`" -e CHOWN_HOME=yes -e NB_UID=`id -u` -e NB_GID=47162 -e USER=`whoami` -e NB_USER=$USER -e NB_GROUP=ECKERLAB -e GRANT_SUDO=yes -e GPU=$GPU -e JUPYTER_ENABLE_LAB=yes max-test
# -w /home/$NB_USER  -v /usr/users/`whoami`:/home/burg

# NV_GPU=$GPU docker run --rm -it --user root --name "`whoami`$GPU-`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`" -e NB_UID=`id -u` -e NB_GID=`id -g` -e NB_USER=$USER -e GRANT_SUDO=yes -e USER=`whoami` -e GPU=$GPU -v `pwd`/..:`pwd`/.. -w `pwd` max-test start.sh $@


# docker run -it --rm -p 8888:8888 --user root -e NB_UID=617278 -e NB_USER=burg -e NB_GID=47162 -e NB_GROUP=ECKERLAB -w /home/burg -e CHOWN_HOME=yes -v /usr/users/burg:/home/burg/work jupyter/scipy-notebook:feacdbfc2e89
# docker run -it --rm -p 8888:8888 --user root -e NB_UID=617278 -e NB_USER=burg -e NB_GID=47162 -e NB_GROUP=ECKERLAB -w /home/burg -e JUPYTER_ENABLE_LAB=yes -e GRANT_SUDO=yes -e CHOWN_HOME=yes -v /usr/users/burg:/home/burg/work jupyter/scipy-notebook:feacdbfc2e89
docker run -it --rm -p 8888:8888 --user root -e NB_UID=617278 -e NB_USER=burg -e NB_GID=47162 -e NB_GROUP=ECKERLAB -w /home/burg -e JUPYTER_ENABLE_LAB=yes -e GRANT_SUDO=yes -e CHOWN_HOME=yes -v /usr/users/burg:/home/burg/work jupyter/scipy-notebook:feacdbfc2e89



# nvidia-docker
# --gpus all



# docker exec -it --user 617278:47162  d617de43e983 /bin/bash