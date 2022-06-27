#!/usr/bin/env bash

set -e

cd "$(dirname $0)"

BUILDTYPE=${1}
shift

export WORKSPACE="$PWD"
export PACKAGES_PATH=$PWD/edk2:$PWD/edk2-platforms:$PWD/globalscale/edk2-platforms:$PWD/edk2-non-osi
export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-

build_uefitools() {
	[ -r .uefitools_done ] && return
	echo " => Building UEFI tools"
	make -C edk2/BaseTools -j$(getconf _NPROCESSORS_ONLN) && touch .uefitools_done
}

build_uefi() {
	vendor=$1
	board=$2
	echo " => Building UEFI for ${vendor} ${board}"
	build -n $(getconf _NPROCESSORS_ONLN) -b ${BUILDTYPE} -a AARCH64 -t GCC5 \
	    -p Platform/${vendor}/${board}/${board}.dsc -D X64EMU_ENABLE
}

. edk2/edksetup.sh

build_uefitools
build_uefi Globalscale Armada70x0McBin

