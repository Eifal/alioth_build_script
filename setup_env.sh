#!/bin/bash

sudo su
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get install -y \
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
  libncurses6 \
  lib32ncurses-dev \
  x11proto-core-dev \
  libx11-dev \
  lib32z1-dev \
  libgl1-mesa-dev \
  libxml2-utils \
  xsltproc \
  unzip \
  fontconfig \
  bc \
  bison \
  build-essential \
  curl \
  flex \
  g++-multilib \
  gcc-multilib \
  git \
  gnupg \
  gperf \
  imagemagick \
  lib32ncurses5-dev \
  lib32readline-dev \
  liblz4-tool \
  libncurses5-dev \
  libsdl1.2-dev \
  libssl-dev \
  lzop \
  pngcrush \
  rsync \
  schedtool \
  squashfs-tools \
  zip \
  zlib1g-dev \
  openjdk-11-jdk \
  python3 \
  python-is-python3 \
  python3-pip \
  libncurses-dev \
  ccache \
  git-lfs

mkdir -p ~/bin
export PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+rx ~/bin/repo

git lfs install

git clone https://github.com/akhilnarang/scripts.git ~/scripts
bash ~/scripts/setup/android_build_env.sh

echo "All necessary packages have been installed and the build environment is set up."
echo "Don't forget to add ~/bin to your PATH if it's not already there."
echo "Example: export PATH=~/bin:\$PATH"

if [ -n "$ZSH_VERSION" ]; then
  echo 'export PATH=~/bin:$PATH' >> ~/.zshrc
  source ~/.zshrc
else
  echo 'export PATH=~/bin:$PATH' >> ~/.bashrc
  source ~/.bashrc
fi

echo "To start building, navigate to your AOSP/LineageOS directory, run 'source build/envsetup.sh', select your lunch target, and then run 'm -j$(nproc --all)'."
