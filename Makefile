#
# Makefile for build GlobalScale MOCHAbin edk2 UEFI
# Copyright (c) 2022, s199p.wa1k9er@gmil.com aka SleepWalker
#
PWD = ${CURDIR}
BIN = bin/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-

COM ?= ${PWD}/${BIN}
ATF ?= ${PWD}/globalscale/atf-marvell
DDR ?= ${PWD}/globalscale/mv-ddr-marvell
SCP ?= ${PWD}/globalscale/binaries-marvell/mrvl_scp_bl2.img

PAR ?= USE_COHERENT_MEM=0 LOG_LEVEL=20 SECURE=0
DEB ?= 0

# 1-8Gbyte / 0-4Gbyte RAM
RAM ?= 1

# RELEASE or DEBUG
VER ?= RELEASE

EFI = ${PWD}/Build/Armada70x0McBin-AARCH64/${VER}_GCC5/FV/ARMADA_EFI.fd

.PHONY:	all
all:	release

get-repos:
	git submodule update --init --recursive

sdk:	${BIN}gcc

${BIN}gcc:
	@mkdir -p bin
	wget -q https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/aarch64-linux-gnu/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz
	tar -xJf gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz -C bin/
	rm -f gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz

${EFI}:	uefi

uefi:
	@./build.sh ${VER}

bl31:
	@echo " => Building BL31"
	make -C ${ATF} CROSS_COMPILE=${COM} MV_DDR_PATH=${DDR} SCP_BL2=${SCP} \
	${PAR} DEBUG=${DEB} DDR_TOPOLOGY=${RAM} PLAT=a70x0_mochabin \
	bl31

fit:	${EFI}
	@echo " => Building UEFI FIT"
	make -C ${ATF} CROSS_COMPILE=${COM} MV_DDR_PATH=${DDR} SCP_BL2=${SCP} \
	${PAR} DEBUG=${DEB} DDR_TOPOLOGY=${RAM} PLAT=a70x0_mochabin \
	BL33=${EFI} \
	all fip mrvl_flash

release/mochabin-8g-uefi.bin:	uefi
	@mkdir -p release
	@make clean_fit
	@make fit RAM=1
	@cp ${PWD}/globalscale/atf-marvell/build/a70x0_mochabin/release/flash-image.bin release/mochabin-8g-uefi.bin

release/mochabin-4g-uefi.bin:	uefi
	@mkdir -p release
	@make clean_fit
	@make fit RAM=0
	@cp ${PWD}/globalscale/atf-marvell/build/a70x0_mochabin/release/flash-image.bin release/mochabin-4g-uefi.bin

release:	release/mochabin-4g-uefi.bin release/mochabin-8g-uefi.bin
	@make show

show:
	@ls -lh ${PWD}/release

clean_fit:
	rm -rf ${PWD}/globalscale/atf-marvell/build

clean_uefi:
	rm -rf ${PWD}/Build

clean_release:
	rm -rf release

clean:
	rm -f .uefitools_done
	@make clean_fit
	@make clean_uefi
	@make clean_release
