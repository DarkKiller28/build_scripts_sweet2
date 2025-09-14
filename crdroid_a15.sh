#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/DarkKiller28/local_manifest.git .repo/local_manifests -b sweet2-crdroid16
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

# Delete Error Line
sed -i '/type lirc_device, dev_type;/d' device/lineage/sepolicy/common/vendor/device.te

# Fix deprecated Soong settings (opsiyonel)
if [ -f vendor/lineage/config/BoardConfigSoong.mk ]; then
    echo "Fixing deprecated Soong settings..."
    sed -i '/TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED/d' vendor/lineage/config/BoardConfigSoong.mk
    sed -i '/TARGET_HEALTH_CHARGING_CONTROL/d' vendor/lineage/config/BoardConfigSoong.mk
    cat <<EOL >> vendor/lineage/config/BoardConfigSoong.mk
soong_config_set(
    name: "override_format_from_reserved",
    module_type: "camera",
    value: true,
)

soong_config_set(
    name: "charging_control_charging_path",
    module_type: "lineage_health",
    value: "/sys/class/power_supply/battery/charge_control_end_threshold",
)

soong_config_set(
    name: "charging_control_charging_enabled",
    module_type: "lineage_health",
    value: true,
)

soong_config_set(
    name: "charging_control_charging_disabled",
    module_type: "lineage_health",
    value: true,
)

soong_config_set(
    name: "charging_control_supports_bypass",
    module_type: "lineage_health",
    value: true,
)
EOL
fi

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch
lunch lineage_sweet2-ap4a-userdebug

# Build
mka bacon
