#!/bin/bash

rm -rf .repo/local_manifests

# repo init rom
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs

# Sync
/opt/crave/resync.sh

# Clone DT
rm -rf device/xiaomi/alioth
rm -rf device/xiaomi/sm8250-common
rm -rf vendor/xiaomi/alioth
rm -rf vendor/xiaomi/sm8250-common
rm -rf kernel/xiaomi/sm8250
rm -rf vendor/xiaomi/camera

git clone --depth 1 -b rising "https://github.com/eprjkt/device_xiaomi_alioth.git" device/xiaomi/alioth
git clone --depth 1 -b rising "https://github.com/eprjkt/device_xiaomi_sm8250-common.git" device/xiaomi/sm8250-common
git clone --depth 1 -b 14-qpr3 "https://github.com/eprjkt/vendor_xiaomi_alioth.git" vendor/xiaomi/alioth
git clone --depth 1 -b 14-qpr3 "https://github.com/eprjkt/vendor_xiaomi_sm8250-common.git" vendor/xiaomi/sm8250-common

git clone --depth 1 -b aosp-14 "https://gitlab.com/Eifal/vendor_xiaomi_camera.git" vendor/xiaomi/camera

git clone --depth 1 -b staging --recurse-submodules "https://github.com/eprjkt/kernel_xiaomi_sm8250.git" kernel/xiaomi/sm8250
git clone --depth 1 -b 14.0 "https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r536225.git" prebuilts/clang/host/linux-x86/clang-r536225
git clone --depth 1 -b lineage-21 "https://github.com/LineageOS/android_hardware_xiaomi.git" hardware/xiaomi

# Build
source build/envsetup.sh
riseup alioth userdebug
yes "" | gk -s
rise b