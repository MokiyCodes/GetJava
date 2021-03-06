#!/bin/zsh
# Downloads GetJava
# For copy-pasting use in other shell scripts
if [ ! -d "JavaDL" ]; then
  echo "Downloading GetJava..."
  # wget -qO- https://github.com/MokiyCodes/GetJava/archive/refs/heads/main.zip | bsdtar -xvf- -C .
  curl -#L https://github.com/MokiyCodes/GetJava/archive/refs/heads/main.zip | bsdtar -xf- -C .
  echo "Moving GetJava-main to JavaDL..."
  mv GetJava-main JavaDL
  echo "Adding Execute Permissions to GetJava..."
  chmod +x JavaDL --recursive
fi
