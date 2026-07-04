#!/bin/bash

rm -rf .repo/local_manifests/

repo init -u https://github.com/AetheriaOS/aetheria_manifest.git -b aetheria-1.0 --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b aetheria-16
echo "============================"
echo "Local manifest clone success"
echo "============================"

/opt/crave/resync.sh 
echo "============="
echo "Sync success"
echo "============="

cd kernel/xiaomi/sm6150 && git submodule update --init --recursive && cd ../../../

export BUILD_USERNAME=DarkKiller 
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

source build/envsetup.sh
echo "============="

lunch aetheria_sweet2-bp4a-userdebug

m bacon -j$(nproc)

mkdir -p imgs_output
cp out/target/product/sweet2/recovery.img imgs_output/
