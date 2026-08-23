set unstable

install(packages) := f"sudo apt-get update && sudo apt-get install -y --no-install-recommends {{ packages }}"

# Install all programs necessary to use and develop the workspace
[default]
all: ros tools

# Install tools necessary for workspace development
tools: _ros-repository
  {{ install("ros-dev-tools python3-vcs2l python3-colcon-clean") }}
  sudo rosdep init && rosdep update

# Add ROS 2 apt repository and install lyrical-desktop
[script]
[arg("DISTRO", pattern="lyrical|rolling|kilted|jazzy|humble", help="ROS 2 distro to install")]
[arg("INSTALLATION", pattern="desktop|desktop-full|perception|ros-base|ros-core", help="specific installation of the distro to install")]
ros DISTRO="lyrical" INSTALLATION="desktop":
  echo "Checking if ros-{{DISTRO}}-{{INSTALLATION}} is installed..."
  if [ -z "$(dpkg -s ros-{{DISTRO}}-{{INSTALLATION}} 2>/dev/null)" ]; then
    echo "Installing ros-{{DISTRO}}-{{INSTALLATION}}..."
    {{ install(f"ros-{{DISTRO}}-{{INSTALLATION}}") }}
  else
    echo "ros-{{DISTRO}}-{{INSTALLATION}} is already installed"
  fi

_ros-repository: _universe-repository
  curl -L -o /tmp/ros2-apt-source.deb https://github.com/ros-infrastructure/ros-apt-source/releases/download/1.2.0/ros2-apt-source_1.2.0.resolute_all.deb
  sudo apt-get update && sudo apt-get install /tmp/ros2-apt-source.deb
  rm /tmp/ros2-apt-source.deb

[script]
_universe-repository:
  echo "Checking if universe repository is enabled..."
  if [ -z "$(apt-cache policy | grep $(lsb_release --codename --short)/universe)" ]; then
    if [ -z "$(command -v add-apt-repository)" ]; then
      echo "Installing software-properties-common..."
      {{ install("software-properties-common") }}
    fi
    echo "Adding universe repository..."
    sudo add-apt-repository universe
  else
    echo "Universe repository is already enabled"
  fi
