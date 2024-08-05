#!/bin/bash

# Remove existing directories
echo "Removing existing directories..."
rm -rf device/xiaomi/alioth
rm -rf device/xiaomi/sm8250-common
rm -rf kernel/xiaomi/sm8250
rm -rf vendor/xiaomi/alioth
rm -rf vendor/xiaomi/sm8250-common
rm -rf vendor/xiaomi/camera

# Clone repositories
echo "Cloning repositories..."
git clone --depth 1 --branch lineage-21-alpha https://github.com/Eifal/android_device_xiaomi_alioth device/xiaomi/alioth
git clone --depth 1 --branch lineage-21-alpha https://github.com/Eifal/android_device_xiaomi_sm8250-common device/xiaomi/sm8250-common
git clone --depth 1 --branch staging https://github.com/EmanuelCN/kernel_xiaomi_sm8250 kernel/xiaomi/sm8250
git clone --depth 1 --branch lineage-21 https://github.com/TheMuppets/proprietary_vendor_xiaomi_alioth vendor/xiaomi/alioth
git clone --depth 1 --branch lineage-21 https://github.com/TheMuppets/proprietary_vendor_xiaomi_sm8250-common vendor/xiaomi/sm8250-common
git clone --depth 1 --branch aosp-14 https://gitlab.com/johnmart19/vendor_xiaomi_camera vendor/xiaomi/camera
git clone --depth 1 --branch main https://github.com/tiann/KernelSU kernel/xiaomi/sm8250/KernelSU

echo "Script completed."
