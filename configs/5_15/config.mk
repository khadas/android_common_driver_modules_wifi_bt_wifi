define to-root-path
$(strip $(patsubst %/,%,$(shell echo\
 $(shell bash -c "\
 cd $(1);\
 while [[ ( ! ( -d project/amlogic ) ) && ( \`pwd\` != "/" ) ]]; do\
  cd ..;\
  echo \"../\";\
 done;"\
 )|sed 's/[[:space:]]//g'))\
)
endef

####################################################################################
# DRIVER_DIR ?= vendor/wifi_driver
ANDROID_ROOT_DIR     ?= $(shell cd $(call to-root-path,.) && pwd)
KERNEL_TO_ROOT_PATH  ?= $(call to-root-path,$(KERNEL_SRC))
WIFI_SUPPORT_DRIVERS ?= $(EXTRA_WIFI_SUPPORT_DRIVERS)
####################################################################################

WIFI_SUPPORT_DRIVERS += dhd_sdio
dhd_sdio_build ?= true
dhd_sdio_modules ?= ap6181 ap6335 ap6234 ap6255 ap6256 ap6271 ap6212 ap6354 ap6356 ap6398s ap6275s bcm43751_s bcm43458_s bcm4358_s
dhd_sdio_src_path ?= $(DRIVER_DIR)/broadcom/ap6xxx/bcmdhd.101.10.591.x
dhd_sdio_copy_path ?= $(OUT_DIR)/../$(strip $(dhd_sdio_src_path))/dhd_sdio
dhd_sdio_build_path ?=
dhd_sdio_args ?= CONFIG_BCMDHD_SDIO=y CONFIG_ANDROID_14=y
ifeq ($(dhd_sdio_build),true)
WIFI_BUILT_MODULES += $(dhd_sdio_modules)
endif

WIFI_SUPPORT_DRIVERS += dhd_usb
dhd_usb_build ?= false
dhd_usb_modules ?= ap6269 ap62x8
dhd_usb_src_path ?= $(DRIVER_DIR)/broadcom/ap6xxx/bcmdhd.101.10.591.x
dhd_usb_copy_path ?= $(OUT_DIR)/../$(strip $(dhd_usb_src_path))/dhd_usb
dhd_usb_build_path ?=
dhd_usb_args ?= CONFIG_BCMDHD_USB=y
ifeq ($(dhd_usb_build),true)
WIFI_BUILT_MODULES += $(dhd_usb_modules)
endif

WIFI_SUPPORT_DRIVERS += dhd_pcie
dhd_pcie_build ?= false
dhd_pcie_modules ?= ap6275p ap6275hh3
dhd_pcie_src_path ?= $(DRIVER_DIR)/broadcom/ap6xxx/bcmdhd.101.10.591.x
dhd_pcie_copy_path ?= $(OUT_DIR)/../$(strip $(dhd_pcie_src_path))/dhd_pcie
dhd_pcie_build_path ?=
dhd_pcie_args ?= CONFIG_BCMDHD_PCIE=y
ifeq ($(dhd_pcie_build),true)
WIFI_BUILT_MODULES += $(dhd_pcie_modules)
endif

WIFI_SUPPORT_DRIVERS += qca6174
qca6174_build ?= true
qca6174_modules ?= qca6174
qca6174_src_path ?= $(DRIVER_DIR)/qualcomm/qca6174
qca6174_copy_path ?=
qca6174_build_path ?= AIO/build
qca6174_args ?= MODNAME=wlan_6174
ifeq ($(qca6174_build),true)
WIFI_BUILT_MODULES += $(qca6174_modules)
endif

WIFI_SUPPORT_DRIVERS += w1
w1_build ?= true
w1_modules ?= w1
w1_src_path ?= $(DRIVER_DIR)/amlogic/w1/wifi
w1_copy_path ?=
w1_build_path ?= project_w1/vmac
w1_args ?=
ifeq ($(w1_build),true)
WIFI_BUILT_MODULES += $(w1_modules)
endif

WIFI_SUPPORT_DRIVERS += w2
w2_build ?= true
w2_modules ?= w2
w2_src_path ?= $(DRIVER_DIR)/amlogic/w2
w2_copy_path ?=
w2_build_path ?= aml_drv
w2_args ?= CONFIG_ANDROID_GKI=y CONFIG_AML_ANDROID=14
ifeq ($(w2_build),true)
WIFI_BUILT_MODULES += $(w2_modules)
endif

WIFI_SUPPORT_DRIVERS += wifi_comm
wifi_comm_build ?= true
wifi_comm_modules ?= wifi_comm
wifi_comm_src_path ?= $(DRIVER_DIR)/amlogic/wifi_comm
wifi_comm_copy_path ?=
wifi_comm_build_path ?=
wifi_comm_args ?=
ifeq ($(wifi_comm_build),true)
WIFI_BUILT_MODULES += $(wifi_comm_modules)
endif

WIFI_SUPPORT_DRIVERS += w1u
w1u_build ?= false
w1u_modules ?= w1u
w1u_src_path ?= $(DRIVER_DIR)/amlogic/w1u
w1u_copy_path ?=
w1u_build_path ?= project_w1u/vmac
w1u_args ?=
ifeq ($(w1u_build),true)
WIFI_BUILT_MODULES += $(w1u_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8723du
rtl8723du_build ?= true
rtl8723du_modules ?= rtl8723du
rtl8723du_src_path ?= $(DRIVER_DIR)/realtek/8723du
rtl8723du_copy_path ?=
rtl8723du_build_path ?= rtl8723DU
rtl8723du_args ?=
ifeq ($(rtl8723du_build),true)
WIFI_BUILT_MODULES += $(rtl8723du_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8723bu
rtl8723bu_build ?= false
rtl8723bu_modules ?= rtl8723bu
rtl8723bu_src_path ?= $(DRIVER_DIR)/realtek/8723bu
rtl8723bu_copy_path ?=
rtl8723bu_build_path ?= rtl8723BU
rtl8723bu_args ?=
ifeq ($(rtl8723bu_build),true)
WIFI_BUILT_MODULES += $(rtl8723bu_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8821cu
rtl8821cu_build ?= true
rtl8821cu_modules ?= rtl8821cu
rtl8821cu_src_path ?= $(DRIVER_DIR)/realtek/8821cu
rtl8821cu_copy_path ?=
rtl8821cu_build_path ?= rtl8821CU
rtl8821cu_args ?=
ifeq ($(rtl8821cu_build),true)
WIFI_BUILT_MODULES += $(rtl8821cu_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8822es
rtl8822es_build ?= true
rtl8822es_modules ?= rtl8822es
rtl8822es_src_path ?= $(DRIVER_DIR)/realtek/8822es
rtl8822es_copy_path ?=
rtl8822es_build_path ?= rtl88x2ES
rtl8822es_args ?=
ifeq ($(rtl8822es_build),true)
WIFI_BUILT_MODULES += $(rtl8822es_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8822cu
rtl8822cu_build ?= true
rtl8822cu_modules ?= rtl8822cu
rtl8822cu_src_path ?= $(DRIVER_DIR)/realtek/8822cu
rtl8822cu_copy_path ?=
rtl8822cu_build_path ?= rtl88x2CU
rtl8822cu_args ?=
ifeq ($(rtl8822cu_build),true)
WIFI_BUILT_MODULES += $(rtl8822cu_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8822eu
rtl8822eu_build ?= true
rtl8822eu_modules ?= rtl8822eu
rtl8822eu_src_path ?= $(DRIVER_DIR)/realtek/8822eu
rtl8822eu_copy_path ?=
rtl8822eu_build_path ?= rtl88x2EU
rtl8822eu_args ?=
ifeq ($(rtl8822eu_build),true)
WIFI_BUILT_MODULES += $(rtl8822eu_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8822cs
rtl8822cs_build ?= true
rtl8822cs_modules ?= rtl8822cs
rtl8822cs_src_path ?= $(DRIVER_DIR)/realtek/8822cs
rtl8822cs_copy_path ?=
rtl8822cs_build_path ?= rtl88x2CS
rtl8822cs_args ?=
ifeq ($(rtl8822cs_build),true)
WIFI_BUILT_MODULES += $(rtl8822cs_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8821cs
rtl8821cs_build ?= false
rtl8821cs_modules ?= rtl8821cs
rtl8821cs_src_path ?= $(DRIVER_DIR)/realtek/8821cs
rtl8821cs_copy_path ?=
rtl8821cs_build_path ?= rtl8821CS
rtl8821cs_args ?=
ifeq ($(rtl8821cs_build),true)
WIFI_BUILT_MODULES += $(rtl8821cs_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8852be
rtl8852be_build ?= true
rtl8852be_modules ?= rtl8852be
rtl8852be_src_path ?= $(DRIVER_DIR)/realtek/8852be
rtl8852be_copy_path ?=
rtl8852be_build_path ?= rtl8852BE
rtl8852be_args ?= CONFIG_RTKM=m
ifeq ($(rtl8852be_build),true)
WIFI_BUILT_MODULES += $(rtl8852be_modules)
endif

WIFI_SUPPORT_DRIVERS += rtl8852bs
rtl8852bs_build ?= true
rtl8852bs_modules ?= rtl8852bs
rtl8852bs_src_path ?= $(DRIVER_DIR)/realtek/8852bs
rtl8852bs_copy_path ?=
rtl8852bs_build_path ?= rtl8852BS
rtl8852bs_args ?=
ifeq ($(rtl8852bs_build),true)
WIFI_BUILT_MODULES += $(rtl8852bs_modules)
endif

WIFI_SUPPORT_DRIVERS += sd8987
sd8987_build ?= false
sd8987_modules ?= sd8987
sd8987_src_path ?= $(DRIVER_DIR)/marvell/sd8987
sd8987_copy_path ?=
sd8987_build_path ?=
sd8987_args ?= KERNELDIR=$(KERNEL_SRC)
ifeq ($(sd8987_build),true)
WIFI_BUILT_MODULES += $(sd8987_modules)
endif

WIFI_SUPPORT_DRIVERS += sd8997
sd8997_build ?= false
sd8997_modules ?= sd8997
sd8997_src_path ?= $(DRIVER_DIR)/marvell/sd8997/wlan_src
sd8997_copy_path ?=
sd8997_build_path ?=
sd8997_args ?= KERNELDIR=$(KERNEL_SRC)
ifeq ($(sd8997_build),true)
WIFI_BUILT_MODULES += $(sd8997_modules)
endif

WIFI_SUPPORT_DRIVERS += iw620
iw620_build ?= false
iw620_modules ?= iw620
iw620_src_path ?= $(DRIVER_DIR)/marvell/iw620
iw620_copy_path ?=
iw620_build_path ?=
iw620_args ?= KERNELDIR=$(KERNEL_SRC)
ifeq ($(iw620_build),true)
WIFI_BUILT_MODULES += $(iw620_modules)
endif

WIFI_SUPPORT_DRIVERS += mt7661
mt7661_build ?= false
mt7661_modules ?= mt7661
mt7661_src_path ?= $(DRIVER_DIR)/mtk/drivers/mt7663u
mt7661_copy_path ?=
mt7661_build_path ?= wlan_driver
mt7661_args ?= CONFIG_MTK_SDIO=y
ifeq ($(mt7661_build),true)
WIFI_BUILT_MODULES += $(mt7661_modules)
endif

WIFI_SUPPORT_DRIVERS += mt7668
mt7668_build ?= false
mt7668_modules ?= mt7668
mt7668_src_path ?= $(DRIVER_DIR)/mtk/drivers/mt7668
mt7668_copy_path ?=
mt7668_build_path ?= drv_wlan/MT6632/wlan
mt7668_args ?=
ifeq ($(mt7668_build),true)
WIFI_BUILT_MODULES += $(mt7668_modules)
endif

WIFI_SUPPORT_DRIVERS += mt7668u
mt7668u_build ?= false
mt7668u_modules ?= mt7668u
mt7668u_src_path ?= $(DRIVER_DIR)/mtk/drivers/mt7668u
mt7668u_copy_path ?=
mt7668u_build_path ?=
mt7668u_args ?=
ifeq ($(mt7668u_build),true)
WIFI_BUILT_MODULES += $(mt7668u_modules)
endif

WIFI_SUPPORT_DRIVERS += mt7663u
mt7663u_build ?= true
mt7663u_modules ?= mt7663u
mt7663u_src_path ?= $(DRIVER_DIR)/mtk/drivers/mt7663u
mt7663u_copy_path ?=
mt7663u_build_path ?= wlan_driver
mt7663u_args ?= CONFIG_MTK_USB=y
ifeq ($(mt7663u_build),true)
WIFI_BUILT_MODULES += $(mt7663u_modules)
endif

WIFI_SUPPORT_DRIVERS += mt7663
mt7663_build ?= false
mt7663_modules ?= mt7663
mt7663_src_path ?= $(DRIVER_DIR)/mtk/drivers/mt7663u
mt7663_copy_path ?=
mt7663_build_path ?= wlan_driver
mt7663_args ?= CONFIG_MTK_SDIO=y
ifeq ($(mt7663_build),true)
WIFI_BUILT_MODULES += $(mt7663_modules)
endif

WIFI_SUPPORT_DRIVERS += uwe5621ds
uwe5621ds_build ?= false
uwe5621ds_modules ?= uwe5621ds
uwe5621ds_src_path ?= $(DRIVER_DIR)/unisoc/uwe5621
uwe5621ds_copy_path ?=
uwe5621ds_build_path ?=
uwe5621ds_args ?=
ifeq ($(uwe5621ds_build),true)
WIFI_BUILT_MODULES += $(uwe5621ds_modules)
endif

WIFI_SUPPORT_DRIVERS += qca206x
qca206x_build ?= false
qca206x_modules ?= qca206x
qca206x_src_path ?= $(DRIVER_DIR)/qualcomm/qca206x
qca206x_copy_path ?=
qca206x_build_path ?= AIO/build
qca206x_args ?= AMLOGIC_ANDROID=y
ifeq ($(qca206x_build),true)
WIFI_BUILT_MODULES += $(qca206x_modules)
endif
