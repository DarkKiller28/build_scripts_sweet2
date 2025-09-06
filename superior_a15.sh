#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/SuperiorOS/manifest.git -b fifteen-los -m stable/latest.xml --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b sweet2-superioros
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
/opt/crave/resync.sh 
echo "============="
echo "Sync success"
echo "============="

# A15 PATH tools fix (use AOSP-prebuilt 'date' instead of host date)
export PATH="$PWD/prebuilts/build-tools/path/linux-x86:$PATH"
echo "Using date at: $(command -v date)"

# Export
export BUILD_USERNAME=DarkKiller 
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Delete Error Line
sed -i '/type lirc_device, dev_type;/d' device/lineage/sepolicy/common/vendor/device.te

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch
breakfast sweet2

# Build
m superior
