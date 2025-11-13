#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/RisingOS-Revived/android -b sixteen --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b sweet2-rising-23.0
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all) 
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
source build/envsetup.sh
echo "============="

# Lunch 
lunch lineage_sweet2-bp2a-userdebug 
lunch lineage_sweet2-bp2a-userdebug

# Lunch Rising
riseup sweet2 userdebug

# Build 
rise b
