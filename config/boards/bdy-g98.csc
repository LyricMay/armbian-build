# Rockchip RK3588 network appliance with SPI-NOR, NVMe and dual RTL8125
BOARD_NAME="BDY G98"
BOARD_VENDOR="bdy"
BOARDFAMILY="rockchip-rk3588"
BOARD_MAINTAINER="LyricMay"
INTRODUCED="2026"
BOOTCONFIG="bdy-g98-rk3588_defconfig"
KERNEL_TARGET="vendor"
KERNEL_TEST_TARGET="vendor"
FULL_DESKTOP="no"
BOOT_LOGO="no"
BOOT_FDT_FILE="rockchip/rk3588-bdy-g98.dtb"
SERIALCON="ttyFIQ0"
BOOT_SCENARIO="spl-blobs"
BOOT_SUPPORT_SPI="yes"
BOOT_SPI_RKSPI_LOADER="yes"
IMAGE_PARTITION_TABLE="gpt"
PACKAGE_LIST_BOARD="ethtool nvme-cli pciutils"


function post_family_config__bdy_g98_use_bootscript() {
	display_alert "$BOARD" "Using BDY G98 bootscript: boot-bdy-g98.cmd -> boot.cmd" "info"
	declare -g BOOTDELAY=2
	declare -g BOOTSCRIPT="boot-bdy-g98.cmd:boot.cmd"
}
