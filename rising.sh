#!/bin/bash

rm -rf .repo/local_manifests

# repo init rom
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs

# local manifests
git clone https://github.com/Eifal/local_manifests -b rising .repo/local_manifests

# Remove existing directories
rm -rf device/xiaomi/alioth
rm -rf device/xiaomi/sm8250-common
rm -rf vendor/xiaomi/alioth
rm -rf vendor/xiaomi/sm8250-common
rm -rf kernel/xiaomi/sm8250
rm -rf vendor/xiaomi/camera

# clone kernel
git clone --recurse-submodules -b magictime-new https://github.com/TIMISONG-dev/kernel_xiaomi_sm8250.git kernel/xiaomi/sm8250

# Sync
/opt/crave/resync.sh

# Build
. build/envsetup.sh
riseup alioth userdebug
yes "" | gk -s
rise b
