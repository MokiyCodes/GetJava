#!/bin/sh
# JDKURL="https://api.adoptium.net/v3/binary/version/jdk-17.0.1%2B12/linux/x64/jdk/hotspot/normal/eclipse?project=jdk";

if [ -d "Java" ]; then
  echo "Found Existing Java Install! Exiting Installer..."
  # echo "JDK Download Cache already exists! Exiting JDK Setup, assuming JDK is in tact. Please remove Java/DLCache to continue"
  # cd ..
  exit 0
else
  echo -e "Java not found - Preparing download tasks"

  if ! command -v node; then
    echo -e "NodeJS could not be found\n  Please install NodeJS"
    exit
  fi
  if ! command -v npm; then
    echo -e "NPM could not be found\n  Please install NodeJS & NPM"
    exit
  else
    packageManager="npm"
  fi
  if command -v yarn; then
    packageManager="yarn"
  fi
  if command -v pnpm; then
    packageManager="pnpm"
  fi
  echo "Using PackageManager $packageManager to install modules..."
  $packageManager install

  echo "Start GetJava.js using Node..."
  node ./GetJava.js

# echo "Downloading httpie (incase it isn't already installed)"
# python -m pip install --upgrade pip wheel >httpie-dl.log 2>httpie-dl.log
# exitCode=$?
# if [ $exitCode != 0 ]; then
#   echo -e "WARN: Python httpie install failed with cde $exitCode. Please see httpie-dl.log\nWARN: Assuming it's already installed"
# else
#   python -m pip install httpie >>httpie-dl.log 2>>httpie-dl.log
#   exitCode=$?
#   if [[ "$exitCode" -ne "0" ]]; then
#     echo -e "WARN: Python httpie install failed with cde $exitCode. Please see httpie-dl.log\nWARN: Assuming it's already installed"
#   else
#     rm httpie-dl.log
#   fi
# fi

# LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/adoptium/temurin17-binaries/releases/latest)
# LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
# ARTIFACT_URL_TMP=$(curl "https://github.com/adoptium/temurin17-binaries/releases/download/$LATEST_VERSION/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz" -I | grep -Fi Location | grep -Eo 'https://[^ >]+' | head -1)
# echo -n $ARTIFACT_URL_TMP >URL.txt
# ARTIFACT_URL=$(cat URL.txt)

# echo "Downloading jdk.tar.gz from $ARTIFACT_URL"
# http "$ARTIFACT_URL" --output jdk.tar.gz
# echo "Downloaded jdk.tar.gz - Extracting to Java Directory"
# cd ..
# tar -xf JavaDLCache/jdk.tar.gz -C ./
# exitCode=$?
# if [[ "$exitCode" -ne "0" ]]; then
#   echo "Tar exited with code $exitCode"
#   exit 1
# fi
# echo "Downloaded Adoptium JDK!"
# cd ..
fi
