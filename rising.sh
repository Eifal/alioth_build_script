#!/bin/bash

rm -rf .repo/local_manifests

# repo init rom
repo init -u https://github.com/RisingTechOSS/android -b fifteen --git-lfs

# Sync
/opt/crave/resync.sh

# Fix MiuiCamera
cd system/libhwbinder
git revert --no-edit 8e047f7
cd -

# Remove existing directories
rm -rf device/xiaomi/alioth
rm -rf device/xiaomi/sm8250-common
rm -rf vendor/xiaomi/alioth
rm -rf vendor/xiaomi/sm8250-common
rm -rf kernel/xiaomi/sm8250
rm -rf vendor/xiaomi/camera
rm -rf hardware/xiaomi

# clone dt
git clone https://codeberg.org/Eifal/device_xiaomi_alioth.git -b rising-15 --depth 1 device/xiaomi/alioth
git clone https://codeberg.org/Eifal/device_xiaomi_sm8250-common.git -b rising-15 --depth 1 device/xiaomi/sm8250-common

# clone vendor
git clone https://github.com/PocoF3Releases/vendor_xiaomi_alioth.git -b aosp-15 --depth 1 vendor/xiaomi/alioth
git clone https://codeberg.org/Eifal/vendor_xiaomi_sm8250-common.git -b rising-15 --depth 1 vendor/xiaomi/sm8250-common

# clone miuicamera
git clone https://codeberg.org/Eifal/vendor_xiaomi_camera.git -b testqpr1 vendor/xiaomi/camera

# clone hardware/xiaomi
git clone https://github.com/PocoF3Releases/hardware_xiaomi.git -b aosp-15 --depth 1 hardware/xiaomi

# clone kernel
git clone --recurse-submodules -b magictime-new https://github.com/TIMISONG-dev/kernel_xiaomi_sm8250.git kernel/xiaomi/sm8250

# frameworks/native
rm -rf frameworks/native
git clone https://github.com/eprjkt/rising_android_frameworks_native.git -b fifteen frameworks/native

# lfs
git lfs pull

# clone custom clang
if [ -d "prebuilts/clang/host/linux-x86/clang-zyc" ]; then
    echo "____________________________________________________________________________________________"
    echo "clang-zyc already exists."
    echo "skip"
    echo "____________________________________________________________________________________________"
else
    echo "____________________________________________________________________________________________"
    echo "clang-zyc not found. Proceeding with Clang cloning process."
    echo "____________________________________________________________________________________________"

    # zyc
    mkdir -p prebuilts/clang/host/linux-x86/clang-zyc
    cd prebuilts/clang/host/linux-x86/clang-zyc
    wget https://github.com/ZyCromerZ/Clang/releases/download/19.0.0git-20240625-release/Clang-19.0.0git-20240625.tar.gz
    tar -xvzf Clang-19.0.0git-20240625.tar.gz
    cd -
fi

# Build
export BUILD_USERNAME=eprjk
export BUILD_HOSTNAME=Alya
. build/envsetup.sh
riseup alioth 
rm -rf out/target/product/alioth
rise b

# upload build to GO-FILE

OUT_DIR="out/target/product/alioth"
BUILD_PACKAGE="$(find "$OUT_DIR" -name "RisingOS-*.zip" -print -quit)"

gofile_upload() {
    local FILE_PATH="$1"
    local FILE_NAME="${FILE_PATH##*/}"

    local response
    response=$(curl -# -F "name=$FILE_NAME" -F "file=@$FILE_PATH" "https://store1.gofile.io/contents/uploadfile")

    local UPLOAD_STATUS
    UPLOAD_STATUS=$(echo "$response" | jq -r '.status')

    if [ "$UPLOAD_STATUS" = 'ok' ]; then
        local URL_ID
        URL_ID=$(echo "$response" | jq -r '.data.downloadPage')

        echo "Download: $URL_ID"
    else
        echo "Upload failed!"
        echo "$response"
    fi
}

if [ -n "$BUILD_PACKAGE" ]; then
    echo "Starting Upload..."
    gofile_upload "$BUILD_PACKAGE"
    # grep -n "ro.system.build.date.utc" "$OUT_DIR/system/system/build.prop"
else
    echo "Build package not found. Upload failed!"
fi
