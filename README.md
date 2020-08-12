# Ubuntu-ROS-Gnome

![bandicam 2020-08-13 00-04-36-359](https://user-images.githubusercontent.com/45775392/90031889-b8e16200-dcf8-11ea-8ef1-66bac61906b2.jpg)

## Description

Docker for ROS with gnome GUI

Catkin build is automaticaly run when you open a terminal.

VNC password was set to `password`.

## Version

- Ubuntu : 18.04
- ROS : melodic
- Python : 2.7

## Checked Environemnt
- ThinkPad X1 carbon
    - OS : Ubuntu 18.04
    - CPU : Core i5 7300U @2.60GHz
    - RAM : 8 GB
- Synology DS216+II
    - OS : DSM 6.2.3-25426 Update 2
    - CPU : Celeron N3060 @1.60GHz
    - RAM : 8 GB

## Installed Softwares

- ros-melodic-desktop-full
- net-tools
- terminator
- nautilus
- gedit
- vim
- pip
- tightvncserver
- FireFox


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



