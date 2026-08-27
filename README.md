# UH URC Team ROS 2 Workspace

This repository contains the ROS 2 workspace for our rover.
All code intended to be run on or interact with the rover will be contained or imported here as a centralized space for integration.

## Table of Contents
<!--ts-->
   * [Getting Started](#getting-started)
      * [Command Line](#command-line)
      * [Git](#git)
      * [ROS](#ros)
      * [Vcs2l](#vcs2l)
   * [ROS](#ros-1)
      * [Installing ROS](#installing-ros)
         * [Container](#container)
            * [Docker](#docker)
               * [VSCode with Docker](#vscode-with-docker)
               * [Running ROS Nodes in Docker](#running-ros-nodes-in-docker)
            * [Distrobox](#distrobox)
         * [Native Installation](#native-installation)
<!--te-->

## Getting Started

### Command Line

### Git

### ROS
Developing or using most of the code in this repository requires an installation of [ROS 2 Lyrical Luth](https://docs.ros.org/en/lyrical).
For information on installation methods, see [Installing ROS](#installing-ros).

### Vcs2l
Additional repositories are pulled into the workspace using [Vcs2l](https://github.com/ros-infrastructure/vcs2l).
To clone them first make sure Vcs2l is installed with
```console
$ just install tools
```
then run
```console
$ vcs import --input rover.repos
```

## ROS

### Installing ROS

> [!IMPORTANT]
> Windows users may have occasional trouble running certain packages, especially those written to be run on the rover.
> A [container installation](#container) or [WSL](https://learn.microsoft.com/en-us/windows/wsl/about) with or without a container is an option for these cases, but these may require extra configuration to run GUI programs or network with other computers (such as the rover) that in the case of WSL may not be available on all devices.
> If possible, [dual booting](https://linuxvox.com/blog/install-ubuntu-on-dual-boot) Ubuntu 26.04 on your Windows machine is ideal, but Windows users should still be able to work with all of the code, they may just need to work with a Linux user when testing hardware.

You have a few options for how you install ros:

#### Container
I recommend using containers when running ROS.
It is integrated with the OS (at least in Ubuntu), so a container makes it easier to isolate the ROS packages and system as well as run the code on a fresh system for testing purposes.
In addition, most of our documentation and helper scripts are written with Ubuntu in mind, so if you don't already run Ubuntu on your computer a container will allow you to use a Ubuntu container and still benefit from them.

##### Docker
By using the proper Docker image, `ros-lyrical` will come preinstalled so you won't need to follow any installation steps.
You can integrate with VSCode for a full programming environment or just run ROS nodes in containers.

###### VSCode with Docker
The Lyrical documentation includes a guide on [setting up ROS 2 with VSCode and Docker](https://docs.ros.org/en/lyrical/How-To-Guides/Setup-ROS-2-with-VSCode-and-Docker-Container).
If you want to do this on Windows I would recommend following [this tutorial](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode) to install VSCode and WSL2.
Then you can follow the guide.
Skip the [Install VS Code](https://docs.ros.org/en/lyrical/How-To-Guides/Setup-ROS-2-with-VSCode-and-Docker-Container.html#install-vs-code) section and when you reach [Add your ROS 2 workspace](https://docs.ros.org/en/lyrical/How-To-Guides/Setup-ROS-2-with-VSCode-and-Docker-Container.html#add-your-ros-2-workspace) instead of making a new workspace `ws`, cd to where you want to have the rover workspace, and run
```console
$ git clone https://github.com/urc-uh/rover-ws.git  # or git@github.com:urc-uh/rover.ws.git if you prefer ssh
$ mkdir .devcontainer
```
Add the devcontainer.json and Dockerfile to the newly created `.devcontainer` directory and follow the rest of the directions.

<!-- TODO: add documentation for Dockerfile when added -->

###### Running ROS Nodes in Docker
If you would like to just use containers to run ROS 2 nodes and program in an isolated environment follow the guide [running ROS 2 nodes in Docker](https://docs.ros.org/en/lyrical/How-To-Guides/Run-2-nodes-in-single-or-separate-docker-containers.html) in the ROS 2 Lyrical documentation.
Using the method only allows you to run nodes and creates a totally isolated container, meaning you will have to clone the workspace, install tools and dependencies, and build any time you start a fresh container before you run nodes.
You also won't be able to effectively set up a programming environment within the container, use code that hasn't been pushed to the git repository, or run GUI programs without additional configuration, so I would recommend still following one of the other installation methods for your development and pre-commit testing environment.

> [!NOTE]
> After following the steps for either Docker method you should be able to follow any other workspace documentation.
> However, these setups haven't been tested with the workspace.
> Please [file a bug report](CONTRIBUTING.md#file-a-bug-report) if anything doesn't work properly.

##### Distrobox
Distrobox is a good option if you use Linux.
It runs containers integrated with the host environment, meaning you will be able to access your files while in the container.
This means you can have a single instance of the workspace and still run it from any distrobox.
It also runs GUI programs and has full host network access out-of-the-box.

You can follow [this tutorial](https://iris-its.github.io/setup-ros-distrobox) to set up distrobox and ROS as well as optionally integrate with VSCode.
Instead of using the suggested image, I recommend using the toolbx Ubuntu 26.04 image that is made to work better with distrobox then [install ROS natively](#native-installation) after entering the image:
```console
$ distrobox create --name rover --image quay.io/toolbx/ubuntu-toolbox:26.04 --home /home/user/path/to/container/home/directory --hostname urc
$ distrobox enter rover
$ cd ~/directory/where/you/want/the/workspace
$ git clone https://github.com/urc-uh/rover-ws.git
$ # now install ros-lyrical
```
It is not required to set `--home` or `--hostname` when creating the distrobox container.
However, I do recommend setting `--home` to a different directory that your user home directory to avoid some user pathing issues that can occur, then cloning this repository inside that home directory.
For more distrobox configuration options, see the [`distrobox-create` documentation](https://distrobox.it/usage/distrobox-create).

#### Native Installation
Follow the ROS 2 lyrical documentation [installation guide](https://docs.ros.org/en/lyrical/Installation.html).

> [!WARNING]
> Only use one of the [binary packages](https://docs.ros.org/en/lyrical/Installation.html#binary-packages) unless you are sure you know what you are doing.
