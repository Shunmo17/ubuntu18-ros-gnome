# Ubuntu-ROS-Gnome

## Description

Docker for ROS with gnome GUI

Catkin build is automaticaly run when you open a terminal.

VNC password was set to `password`.

## Version

- Ubuntu : 18.04
- ROS : melodic
- Python : 2.7



## Installed Softwares

- ros-melodic-desktop-full
- net-tools
- terminator
- nautilus
- gedit
- vim
- pip
- tightvncserver



## Usage

### build

```
docker build \
    --rm \
    --tag ubuntu-ros-gnome:latest \
    .
```

or

```
./build.sh
```



### docker run

```
docker run -it  \
    --rm \
    --net host \
    ubuntu-ros-gnome:latest
```

or

```
docker run -it  \
    --rm \
    --p 5901:5901 \
    ubuntu-ros-gnome:latest
```

or

```
./run.sh
```



## Connect to VNC Server

Open your VNC Client, and then type below.

```
vnc://localhost:5901
```



If you use this docker not in local pc, use below instead of above.

```
vnc://{IP_ADDRESS}:5901
```





## Others

### alias

```
cd {DIR} = cd {DIR} && ls 
```



