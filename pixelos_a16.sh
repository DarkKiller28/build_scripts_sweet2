#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf prebuilts/clang/host/linux-x86

# repo init rom
repo init -u https://github.com/PixelOS-AOSP/android_manifest.git -b sixteen-qpr2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b sweet2-pixelos16
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Kernel init
cd kernel/xiaomi/sm6150 && git submodule update --init --recursive && cd .. && cd .. && cd ..

# Build Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=DarkKiller 
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch
breakfast sweet2

# Build
m pixelos
