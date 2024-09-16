#!/bin/bash

# Install necessary packages with sudo
sudo apt-get update
sudo apt-get install -y \
  git-core \
  gnupg \
  flex \
  bison \
  build-essential \
  zip \
  curl \
  zlib1g-dev \
  gcc-multilib \
  g++-multilib \
  libc6-dev-i386 \
  libncurses-dev \
  lib32ncurses-dev \
  libncurses5 \
  lib32ncurses5-dev \
  libtinfo5 \
  x11proto-core-dev \
  libx11-dev \
  lib32z1-dev \
  libgl1-mesa-dev \
  libxml2-utils \
  xsltproc \
  unzip \
  fontconfig \
  bc \
  gperf \
  imagemagick \
  lib32readline-dev \
  liblz4-tool \
  libsdl1.2-dev \
  libssl-dev \
  lzop \
  pngcrush \
  rsync \
  schedtool \
  squashfs-tools \
  openjdk-11-jdk \
  python3 \
  python-is-python3 \
  python3-pip \
  ccache \
  git-lfs \
  libarchive-tools \
  device-tree-compiler

# Set up repo tool
mkdir -p ~/bin
export PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+rx ~/bin/repo

# Set up Git LFS
git lfs install

# Clone and run Android build environment setup script
git clone https://github.com/akhilnarang/scripts.git ~/scripts
bash ~/scripts/setup/android_build_env.sh

# Add ~/bin to PATH in shell configuration
if [ -n "$ZSH_VERSION" ]; then
  echo 'export PATH=~/bin:$PATH' >> ~/.zshrc
  source ~/.zshrc
else
  echo 'export PATH=~/bin:$PATH' >> ~/.bashrc
  source ~/.bashrc
fi

# Completion message
echo "All necessary packages have been installed and the build environment is set up."
