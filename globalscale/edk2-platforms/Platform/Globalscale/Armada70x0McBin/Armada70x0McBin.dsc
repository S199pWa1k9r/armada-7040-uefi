#Copyright (C) 2016 Marvell International Ltd.
#
#SPDX-License-Identifier: BSD-2-Clause-Patent
#
################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                  = Armada70x0McBin
  PLATFORM_GUID                  = f837e231-cfc7-4f56-9a0f-5b218d746ae3
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/$(PLATFORM_NAME)-$(ARCH)
  SUPPORTED_ARCHITECTURES        = AARCH64|ARM
  BUILD_TARGETS                  = DEBUG|RELEASE|NOOPT
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = Silicon/Marvell/Armada7k8k/Armada7k8k.fdf
  BOARD_DXE_FV_COMPONENTS        = Platform/Globalscale/Armada70x0McBin/Armada70x0McBin.fdf.inc
  CAPSULE_ENABLE                 = TRUE

  #
  # Network definition
  #
  DEFINE NETWORK_IP6_ENABLE             = FALSE
  DEFINE NETWORK_TLS_ENABLE             = FALSE
  DEFINE NETWORK_HTTP_BOOT_ENABLE       = FALSE
  DEFINE NETWORK_ISCSI_ENABLE           = FALSE

!include Silicon/Marvell/Armada7k8k/Armada7k8k.dsc.inc

!include MdePkg/MdeLibs.dsc.inc

[Components.common]
  Platform/Marvell/Armada7k8k/DeviceTree/Armada70x0McBin.inf

[Components.AARCH64]
 Platform/Marvell/Armada7k8k/AcpiTables/Armada70x0McBin.inf

[LibraryClasses.common]
  ArmadaBoardDescLib|Platform/Globalscale/Armada70x0McBin/Armada70x0McBinBoardDescLib/Armada70x0McBinBoardDescLib.inf
  NonDiscoverableInitLib|Platform/Globalscale/Armada70x0McBin/NonDiscoverableInitLib/NonDiscoverableInitLib.inf

################################################################################
#
# Pcd Section - list of all EDK II PCD Entries defined by this Platform
#
################################################################################
[PcdsFixedAtBuild.common]
  # Platform description
  # SMBIOS/DMI
  gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString|L"EDK2 SW 1.0"
  gMarvellTokenSpaceGuid.PcdProductManufacturer|"GlobalScale"
  gMarvellTokenSpaceGuid.PcdProductPlatformName|"Armada 7040 MochaBin" 
  gMarvellTokenSpaceGuid.PcdProductVersion|"Rev. 1.1"
  gMarvellTokenSpaceGuid.PcdProductSerial|"Serial Not Set"
  gMarvellTokenSpaceGuid.PcdFirmwareVersion|"EDK2 SW 1.1"

  # CP110 count
  gMarvellTokenSpaceGuid.PcdMaxCpCount|1

  # MPP
  gMarvellTokenSpaceGuid.PcdMppChipCount|2

  # APN806-A0 MPP SET
  gMarvellTokenSpaceGuid.PcdChip0MppReverseFlag|FALSE
  gMarvellTokenSpaceGuid.PcdChip0MppBaseAddress|0xF06F4000
  gMarvellTokenSpaceGuid.PcdChip0MppPinCount|20
  gMarvellTokenSpaceGuid.PcdChip0MppSel0|{ 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1 }
  gMarvellTokenSpaceGuid.PcdChip0MppSel1|{ 0x1, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3 }

  # CP110 MPP SET - Router configuration
  gMarvellTokenSpaceGuid.PcdChip1MppReverseFlag|FALSE
  gMarvellTokenSpaceGuid.PcdChip1MppBaseAddress|0xF2440000
  gMarvellTokenSpaceGuid.PcdChip1MppPinCount|64
  gMarvellTokenSpaceGuid.PcdChip1MppSel0|{ 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4 }
  gMarvellTokenSpaceGuid.PcdChip1MppSel1|{ 0x4, 0x4, 0x0, 0x3, 0x3, 0x3, 0x3, 0x0, 0x0, 0x0 }
  gMarvellTokenSpaceGuid.PcdChip1MppSel2|{ 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x9, 0xA }
  gMarvellTokenSpaceGuid.PcdChip1MppSel3|{ 0xA, 0x0, 0x7, 0x0, 0x7, 0x7, 0x7, 0x2, 0x2, 0x0 }
  gMarvellTokenSpaceGuid.PcdChip1MppSel4|{ 0x0, 0x0, 0x0, 0x0, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1 }
  gMarvellTokenSpaceGuid.PcdChip1MppSel5|{ 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0xE, 0xE, 0xE, 0xE }
  gMarvellTokenSpaceGuid.PcdChip1MppSel6|{ 0xE, 0xE, 0xE, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0 }

  # I2C
  gMarvellTokenSpaceGuid.PcdI2cSlaveAddresses|{ 0x50, 0x57, 0x60, 0x21 }
  gMarvellTokenSpaceGuid.PcdI2cSlaveBuses|{ 0x0, 0x0, 0x0, 0x0 }
  gMarvellTokenSpaceGuid.PcdI2cControllersEnabled|{ 0x1, 0x1, 0x0 }
  gMarvellTokenSpaceGuid.PcdEepromI2cAddresses|{ 0x50, 0x57 }
  gMarvellTokenSpaceGuid.PcdEepromI2cBuses|{ 0x1, 0x1 }
  gMarvellTokenSpaceGuid.PcdI2cClockFrequency|250000000
  gMarvellTokenSpaceGuid.PcdI2cBaudRate|100000
  gMarvellTokenSpaceGuid.PcdI2cBusCount|2

  # SPI
  gMarvellTokenSpaceGuid.PcdSpiRegBase|0xF2700680
  gMarvellTokenSpaceGuid.PcdSpiMaxFrequency|10000000
  gMarvellTokenSpaceGuid.PcdSpiClockFrequency|200000000
  gMarvellTokenSpaceGuid.PcdSpiFlashMode|3
  gMarvellTokenSpaceGuid.PcdSpiFlashCs|0

  # ComPhy
  # 0: SGMII1       3.125 Gbps
  # 1: USB3_HOST0   5 Gbps
  # 2: SATA0        5 Gbps
  # 3: SATA1        5 Gbps
  # 4: SFI          10.3125 Gbps
  # 5: PCIE2        5 Gbps
  gMarvellTokenSpaceGuid.PcdComPhyDevices|{ 0x1 }
  gMarvellTokenSpaceGuid.PcdChip0ComPhyTypes|{ $(CP_SGMII1), $(CP_USB3_HOST0), $(CP_SATA0), $(CP_SATA1), $(CP_SFI), $(CP_PCIE2) }
  gMarvellTokenSpaceGuid.PcdChip0ComPhySpeeds|{ $(CP_3_125G), $(CP_5G), $(CP_5G), $(CP_5G), $(CP_10_3125G), $(CP_5G) }

  # UtmiPhy
  gMarvellTokenSpaceGuid.PcdUtmiControllersEnabled|{ 0x1, 0x1 }
  gMarvellTokenSpaceGuid.PcdUtmiPortType|{ $(UTMI_USB_HOST0), $(UTMI_USB_HOST1) }

  # MDIO
  gMarvellTokenSpaceGuid.PcdMdioControllersEnabled|{ 0x1, 0x0 }

  # PHY
  gMarvellTokenSpaceGuid.PcdPhy2MdioController|{ 0x0, 0x0 }
  gMarvellTokenSpaceGuid.PcdPhyDeviceIds|{ 0x0, 0x0 }
  gMarvellTokenSpaceGuid.PcdPhySmiAddresses|{ 0x0, 0x1 }
  gMarvellTokenSpaceGuid.PcdPhyStartupAutoneg|FALSE

  # NET
  gMarvellTokenSpaceGuid.PcdPp2GopIndexes|{ 0x0, 0x2, 0x3 }
  gMarvellTokenSpaceGuid.PcdPp2InterfaceAlwaysUp|{ 0x1, 0x1, 0x1 }
  gMarvellTokenSpaceGuid.PcdPp2InterfaceSpeed|{ $(PHY_SPEED_10000), $(PHY_SPEED_2500), $(PHY_SPEED_1000) }
  gMarvellTokenSpaceGuid.PcdPp2PhyConnectionTypes|{ $(PHY_SFI), $(PHY_SGMII), $(PHY_RGMII) }
  gMarvellTokenSpaceGuid.PcdPp2PhyIndexes|{ 0xFF, 0x0, 0x1 }
  gMarvellTokenSpaceGuid.PcdPp2Port2Controller|{ 0x0, 0x0, 0x0 }
  gMarvellTokenSpaceGuid.PcdPp2PortIds|{ 0x0, 0x1, 0x2 }
  gMarvellTokenSpaceGuid.PcdPp2Controllers|{ 0x1 }

  # NonDiscoverableDevices
  gMarvellTokenSpaceGuid.PcdPciEXhci|{ 0x1, 0x1 }
  gMarvellTokenSpaceGuid.PcdPciEAhci|{ 0x1 }
  gMarvellTokenSpaceGuid.PcdPciESdhci|{ 0x1 }

  # RTC
  gMarvellTokenSpaceGuid.PcdRtcBaseAddress|0xF2284000

