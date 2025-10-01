#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/ProjectMatrixx/android.git -b 15.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b sweet2-matrix
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) 
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=DarkKiller 
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Delete lirc_device
sed -i '/type lirc_device, dev_type;/d' device/lineage/sepolicy/common/vendor/device.te

# Set up build environment
source build/envsetup.sh
echo "============="

# Build
brunch sweet2
