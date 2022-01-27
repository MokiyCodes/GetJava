#!/bin/zsh
# Downloads GetJava
# For copy-pasting use in other shell scripts
if [ ! -d "JavaDL" ]; then
  echo "Downloading GetJava..."
  wget -qO- https://github.com/MokiyCodes/GetJava/archive/refs/heads/main.zip | bsdtar -xvf- -C .
  mv GetJava-main JavaDL
fi
