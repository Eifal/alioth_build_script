#!/bin/bash

rm -rf .repo/local_manifests

# repo init rom
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs

# local manifests
git clone https://github.com/eprjkt/local_manifests -b main .repo/local_manifests

# Remove existing directories
rm -rf device/xiaomi/alioth
rm -rf device/xiaomi/sm8250-common
rm -rf vendor/xiaomi/alioth
rm -rf vendor/xiaomi/sm8250-common
rm -rf kernel/xiaomi/sm8250
rm -rf vendor/xiaomi/camera

# Sync
/opt/crave/resync.sh

# Build
. build/envsetup.sh
riseup alioth userdebug
yes "" | gk -s
rise b