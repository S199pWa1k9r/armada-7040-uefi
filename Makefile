#
# Makefile for build GlobalScale edk2 UEFI
# Copyright (c) 2022, s199p.wa1k9er@gmil.com aka SleepWalker
#
PWD = ${CURDIR}
COM ?= /opt/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- 

ATF ?= ${PWD}/globalscale/atf-marvell
DDR ?= ${PWD}/globalscale/mv-ddr-marvell
UBT ?= ${PWD}/globalscale/u-boot-marvell

SCP ?= ${PWD}/globalscale/binaries-marvell/mrvl_scp_bl2.img

PAR ?= USE_COHERENT_MEM=0 LOG_LEVEL=20 SECURE=0
DEB ?= 0
RAM ?= 1		# 1-8Gbyte/0-4Gbyte RAM

# RELEASE or DEBUG
VER ?= RELEASE

EFI = ${PWD}/Build/Armada70x0McBin-AARCH64/${VER}_GCC5/FV/ARMADA_EFI.fd

.PHONY:	all
#all:	get-repos release
all:	release

get-repos:
	git -C edk2 submodule update --init --recursive
	git -C edk2-non-osi submodule update --init --recursive
	git -C edk2-platforms submodule update --init --recursive

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
	make -C ${ATF} CROSS_COMPILE=${COM} MV_DDR_PATH=${DDR} SCP_BL2=${SCP} BL33=${PWD}/Build/Armada70x0McBin-AARCH64/${VER}_GCC5/FV/ARMADA_EFI.fd \
	${PAR} DEBUG=${DEB} DDR_TOPOLOGY=${RAM} PLAT=a70x0_mochabin \
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

release:	release/mochabin-8g-uefi.bin release/mochabin-4g-uefi.bin
	@make show

show:
	@ls -lsa ${PWD}/release

clean_fit:
	@rm -rf ${PWD}/globalscale/atf-marvell/build

clean_uefi:
	@rm -rf ${PWD}/Build

clean_release:
	@rm -rf release

clean:
	@make clean_fit
	@make clean_uefi
	@make clean_release
