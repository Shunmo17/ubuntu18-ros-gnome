#! /bin/bash

# if you mout host network
docker run -it  \
    --rm \
    --net host \
    ubuntu-ros-gnome:latest

# if you not mount host network
# docker run -it  \
#     --rm \
#     --p 5901:5901 \
#     ubuntu-ros-gnome:latest