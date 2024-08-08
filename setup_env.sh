#!/bin/bash

# Add OpenJDK repository
add-apt-repository ppa:openjdk-r/ppa

# Update package list
apt-get update

# Install necessary packages
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
  libncurses-dev \
  ccache \
  git-lfs

# Install libtinfo5
wget http://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.4-2_amd64.deb
sudo dpkg -i libtinfo5_6.4-2_amd64.deb
rm -f libtinfo5_6.4-2_amd64.deb

# Install libncurses5
wget http://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libncurses5_6.4-2_amd64.deb
sudo dpkg -i libncurses5_6.4-2_amd64.deb
rm -f libncurses5_6.4-2_amd64.deb

# Install additional ncurses packages
sudo apt install lib32ncurses5-dev libncurses5 libncurses5-dev -y

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

# Completion messages
echo "All necessary packages have been installed and the build environment is set up."
echo "Don't forget to add ~/bin to your PATH if it's not already there."
echo "Example: export PATH=~/bin:\$PATH"
echo "To start building, navigate to your AOSP/LineageOS directory, run 'source build/envsetup.sh', select your lunch target, and then run 'm -j$(nproc --all)'."

# Exit the script
exit 0
