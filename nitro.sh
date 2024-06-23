#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/nitrogen-project/android_manifest.git -b 14 --depth=1

# Clone local_manifests repository
git clone https://github.com/Eifal/local_manifests --depth 1 .repo/local_manifests

# Remove something
if [ -d "prebuilts/clang/host/linux-x86" ]; then
    cd prebuilts/clang/host/linux-x86
    git reset --hard HEAD
    cd -
fi

if [ -d "prebuilts/rust" ]; then
    cd prebuilts/rust
    git reset --hard HEAD
    cd -
fi

# Sync the repositories
curl https://raw.githubusercontent.com/sounddrill31/docker-images/04449990912b9d7ee594193883740037f0ac80a7/aosp/common/resync.sh | bash

# Custom build commands
source build/envsetup.sh
breakfast alioth userdebug
make 

# Sign build (add your signing commands here)
# sign_build_commands_here
