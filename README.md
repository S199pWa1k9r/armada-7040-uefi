# UEFI for GlobalScale MOCHAbin Platforms

This is a source-code collection for building UEFI firmware for GlobalScale MOCHAbin,
based on the [System Ready ES](https://developer.arm.com/architectures/system-architectures/arm-systemready/es) 
compliant [EDK2 Firmware by Semihalf](https://github.com/Semihalf/edk2-platforms/wiki).

Binaries produced from this collection should be functionally equivalent to the Semihalf SH 1.0 Release.

# Compile

Fetch all sources:

    git clone -b develop https://github.com/S199pWa1k9r/armada-7040-uefi.git
    cd armada-7040-uefi
    make get-repos 
    make sdk

Configure cross-compiler:

    export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
    export CROSS_COMPILE=aarch64-linux-gnu-

Setup EDK2 build-environment:

    export PACKAGES_PATH=$PWD/edk2:$PWD/edk2-platforms:$PWD/globalscale/edk2-platforms:$PWD/edk2-non-osi
    export EDK_TOOLS_PATH=$PWD/edk2/BaseTools
    source edk2/edksetup.sh

Build EDK2 Tools (only needed once)

    make -C edk2/BaseTools

Build EDK2 for a target device:

    build -a AARCH64 -b RELEASE -t GCC5 -p globalscale/edk2-platforms/Platform/Globalscale/Armada70x0McBin/Armada70x0McBin.dsc -D X64EMU_ENABLE

Build Firmware image with Marvell ATF:

    make -C globalscale/atf-marvell \
    	PLAT=a70x0_mochabin \
    	MV_DDR_PATH=$PWD/globalscale/mv-ddr-marvell \
    	SCP_BL2=$PWD/globalscale/binaries-marvell/mrvl_scp_bl2.img \
    	BL33=$PWD/Build/Armada70x0McBin-AARCH64/RELEASE_GCC5/FV/ARMADA_EFI.fd \
    	all fip mrvl_flash

Find the bootable firmware image:

    ls -lh globalscale/atf-marvell/build/a70x0_mochabin/release/flash-image.bin

Clean build tree for next fresh attempt:

    rm -rf Build globalscale/atf-marvell/build

