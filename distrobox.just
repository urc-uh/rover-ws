update: && update
  apt update && apt upgrade -y

create name:
  ?distrobox assemble create --name {{name}}

setup name="urc" additional-packages="" external-commands="": (distrobox-create name)
  distrobox enter {{name}} -- /usr/bin/distrobox-host-exec just _distrobox_setup "{{additional-packages}}" "{{external-commands}}" && exit

_setup install-packages="" external-commands="":
  curl -L -o /tmp/ros2-apt-source.deb https://github.com/ros-infrastructure/ros-apt-source/releases/download/1.2.0/ros2-apt-source_1.2.0.resolute_all.deb
  sudo apt update && sudo apt install /tmp/ros2-apt-source.deb
  rm /tmp/ros2-apt-source.deb
  sudo apt update && sudo apt install -y --no-install-recommends ros-lyrical-desktop=0.13.0-3*
  sudo apt update && sudo apt install -y --no-install-recommends python3-vcs2l python3-colcon-clean {{install-packages}}
  sudo mv ~/just /usr/local/bin
  curl -LsSf https://astral.sh/uv/install.sh | sh
  curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py | python3
  @for ec in {{external-commands}}; do echo "Linking ${ec} to host"; ln -s /usr/bin/distrobox-host-exec /usr/local/bin/$ec; done
