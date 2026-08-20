devtools: uv
  sudo apt install -y --no-install-recommends python3-vcs2l python3-colcon-clean
  uv sync --frozen --group dev

uv := shell("which uv || true")
# Install uv python package and virtual environment manager
uv:
  eval {{ if uv == "" { "curl -LsSf https://astral.sh/uv/install.sh | sh" } else { "" } }}

# Add ROS 2 apt repository and install lyrical-desktop
ros:
  sudo apt update && sudo apt install -y --no-install-recommends software-properties-common
  sudo add-apt-repository -y universe
  curl -L -o /tmp/ros2-apt-source.deb https://github.com/ros-infrastructure/ros-apt-source/releases/download/1.2.0/ros2-apt-source_1.2.0.resolute_all.deb
  sudo apt update && sudo apt install /tmp/ros2-apt-source.deb
  rm /tmp/ros2-apt-source.deb
  sudo apt update && sudo apt install -y --no-install-recommends ros-lyrical-desktop=0.13.0-3*
