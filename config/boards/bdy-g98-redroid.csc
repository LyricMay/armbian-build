# BDY G98 profile for CNflysky ReDroid on RK3588
source "${SRC}/config/boards/bdy-g98.csc"

function image_specific_armbian_env_ready__bdy_g98_redroid_verbose_console() {
	# Keep the generic RK35xx environment quiet, but expose kernel boot logs on
	# this server-oriented image for serial diagnosis.
	if grep -q '^verbosity=' "${SDCARD}/boot/armbianEnv.txt"; then
		run_host_command_logged sed -i 's/^verbosity=.*/verbosity=7/' "${SDCARD}/boot/armbianEnv.txt"
	else
		run_host_command_logged echo 'verbosity=7' '>>' "${SDCARD}/boot/armbianEnv.txt"
	fi
}

BOARD_NAME="BDY G98 ReDroid"
BOARD_VENDOR="bdy"
BOARDFAMILY="rockchip-rk3588"
BOARD_MAINTAINER="LyricMay"
INTRODUCED="2026"
KERNEL_TARGET="vendor"
KERNEL_TEST_TARGET="vendor"

function custom_kernel_config__bdy_g98_redroid_39_bit_va() {
	# ReDroid userspace expects a 39-bit ARM64 virtual address space.
	# SELinux must be the active major LSM so Android image layers carrying
	# security.selinux extended attributes can be unpacked when needed.
	if [[ -f .config ]]; then
		kernel_config_set_y CONFIG_ARM64_4K_PAGES
		kernel_config_set_n CONFIG_ARM64_VA_BITS_48
		kernel_config_set_y CONFIG_ARM64_VA_BITS_39
		kernel_config_set_y CONFIG_ARM64_PA_BITS_48
		kernel_config_set_n CONFIG_DEFAULT_SECURITY_DAC
		kernel_config_set_y CONFIG_SECURITY_SELINUX
		kernel_config_set_y CONFIG_DEFAULT_SECURITY_SELINUX
		kernel_config_set_y CONFIG_SECURITY_SELINUX_BOOTPARAM
		kernel_config_set_string CONFIG_LSM "lockdown,yama,loadpin,safesetid,integrity,selinux,bpf"
		kernel_config_set_y CONFIG_DMABUF_HEAPS
		kernel_config_set_y CONFIG_DMA_CMA
		kernel_config_set_y CONFIG_DMABUF_HEAPS_SYSTEM
		kernel_config_set_y CONFIG_DMABUF_HEAPS_CMA
		kernel_config_set_y CONFIG_DMABUF_HEAPS_ROCKCHIP_SYSTEM
		kernel_config_set_y CONFIG_DMABUF_HEAPS_CMA_LEGACY
	else
		kernel_config_modifying_hashes+=(
			"CONFIG_ARM64_4K_PAGES=y"
			"CONFIG_ARM64_VA_BITS_48=n"
			"CONFIG_ARM64_VA_BITS_39=y"
			"CONFIG_ARM64_PA_BITS_48=y"
			"CONFIG_DEFAULT_SECURITY_DAC=n"
			"CONFIG_SECURITY_SELINUX=y"
			"CONFIG_DEFAULT_SECURITY_SELINUX=y"
			"CONFIG_SECURITY_SELINUX_BOOTPARAM=y"
			"CONFIG_DMABUF_HEAPS=y"
			"CONFIG_DMA_CMA=y"
			"CONFIG_DMABUF_HEAPS_SYSTEM=y"
			"CONFIG_DMABUF_HEAPS_CMA=y"
			"CONFIG_DMABUF_HEAPS_ROCKCHIP_SYSTEM=y"
			"CONFIG_DMABUF_HEAPS_CMA_LEGACY=y"
			'CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,bpf"'
		)
	fi
}
