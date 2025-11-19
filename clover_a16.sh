#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/The-Clover-Project/manifest.git -b 16-qpr1 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b sweet2-clover
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all) 
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
lunch clover_sweet2-bp3a-userdebug

# Build
mka clover -j$(nproc --all)
