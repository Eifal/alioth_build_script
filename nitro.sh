#!/bin/bash

# Removals
rm -rf .repo/local_manifests

# Initialize repo with specified manifest
repo init -u https://github.com/nitrogen-project/android_manifest.git -b 14 --depth=1

# Clone local_manifests repository
git clone https://github.com/Eifal/local_manifests --depth 1 .repo/local_manifests

# Sync the repositories
curl https://raw.githubusercontent.com/sounddrill31/docker-images/04449990912b9d7ee594193883740037f0ac80a7/aosp/common/resync.sh | bash

#customs

#build
source build/envsetup.sh
lunch nitrogen_alioth-ap1a-userdebug
make bacon VERBOSE=1

#sign build