#!/bin/bash

rm -rf .repo/local_manifests

# repo init rom
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs

# local manifests
git clone https://github.com/Eifal/local_manifests -b rising .repo/local_manifests

# Sync
/opt/crave/resync.sh

# Build
. build/envsetup.sh
riseup alioth userdebug
yes "" | gk -s
rise b