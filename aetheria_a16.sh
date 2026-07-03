#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/AetheriaOS/aetheria_manifest.git -b aetheria-1.0
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b aetheria-16
echo "============================"
echo "Local manifest clone success"
echo "============================"


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
lunch aetheria_sweet2-bp4a-userdebug

# Build
m bacon -j$(nproc)

# Copy imgs to a separate folder for easy download
mkdir -p imgs_output
cp out/target/product/peridot/recovery.img imgs_output/
