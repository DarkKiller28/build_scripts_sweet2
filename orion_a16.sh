#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/OrionOS-Project/manifest -b bka --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b sweet2-orion16
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune --retry-fetches=5 -j$(nproc --all)
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
lunch lineage_sweet2-bp2a-userdebug

# Build
mka orion -j$(nproc --all)
