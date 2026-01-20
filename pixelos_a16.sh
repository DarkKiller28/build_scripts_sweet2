#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf kernel/xiaomi/sm6150/KernelSU

# repo init rom
repo init -u https://github.com/PixelOS-AOSP/android_manifest.git -b sixteen-qpr1 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b sweet2-pixelos16
echo "============================"
echo "Local manifest clone success"
echo "============================"

# KernelSU
git clone https://github.com/backslashxx/KernelSU kernel/xiaomi/sm6150/KernelSU

# Build Sync
repo sync -j$(nproc) --force-sync --optimized-fetch --no-tags --prune
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
