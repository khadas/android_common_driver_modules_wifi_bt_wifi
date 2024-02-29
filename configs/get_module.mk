##################################################
PLATORM_PATH ?= project/$(MANUFACTURER)
WIFI_BOARD_CONFIG := $(TOP_DIR)/$(PLATORM_PATH)/$(BOARD)/wifibt.build.config.trunk.mk
LOCAL_CONFIG_BUILD_MODULES = $(CONFIG_WIFI_MODULES)
LOCAL_WIFI_SUPPORT_DRIVERS = $(WIFI_SUPPORT_DRIVERS)
ifeq ($(DRIVER_IN_KERNEL),true)
WIFI_DEFAULT_CONFIG ?= $(TOP_DIR)/common14-5.15/driver_modules/wifi_bt/wifi/configs/5_15/config.mk
LOCAL_ROOT_DIR := $(TOP_DIR)/common14-5.15/driver_modules/wifi_bt/wifi
else
WIFI_DEFAULT_CONFIG ?= $(TOP_DIR)/driver_modules/wifi_bt/wifi/configs/5_15/config.mk
LOCAL_ROOT_DIR := $(TOP_DIR)/driver_modules/wifi_bt/wifi
endif
##################################################

include $(WIFI_BOARD_CONFIG)
include $(WIFI_DEFAULT_CONFIG)

#$(warning TOP_DIR = $(TOP_DIR))
#$(warning MANUFACTURER= $(MANUFACTURER))
#$(warning BOARD = $(BOARD))
#$(warning WIFI_CONFIG = $(WIFI_BOARD_CONFIG))
#$(warning CONFIG_WIFI_MODULES = $(LOCAL_CONFIG_BUILD_MODULES))
#$(warning WIFI_BUILT_MODULES = $(WIFI_BUILT_MODULES))
#$(warning WIFI_SUPPORT_DRIVERS = $(WIFI_SUPPORT_DRIVERS))
#$(warning DRIVER_IN_KERNEL = $(DRIVER_IN_KERNEL))

define get-drv-src-path
$(strip $($(1)_src_path))
endef

define get-drv-makefile-path
$(strip $(patsubst %/,%,$(call get-drv-src-path,$(1))/$(strip $($(1)_build_path))))
endef

define drv-is-existed
$(shell if [ -f $(1)/Makefile -o -f $(1)/makefile ]; then echo "true"; else echo "false"; fi)
endef

define get-wifi-drivers
$(strip \
 $(foreach driver,\
  $(LOCAL_WIFI_SUPPORT_DRIVERS),\
  $(if $(filter true,$($(driver)_build)),\
   $(if $(filter true,$(call drv-is-existed,$(LOCAL_ROOT_DIR)/$(call get-drv-makefile-path,$(driver)))),$(driver))))\
)
endef

IGNORE_MODULES :=
IGNORE_DRIVERS :=

define ignored-drivers
$(foreach driver,\
 $(LOCAL_WIFI_SUPPORT_DRIVERS),\
 $(if $(filter true,$($(driver)_build)),\
  $(if $(filter false,$(call drv-is-existed,$(LOCAL_ROOT_DIR)/$(call get-drv-makefile-path,$(driver)))),\
   $(eval IGNORE_DRIVERS += $(driver))))\
)
endef

define ignored-modules
$(eval all_modules := $(foreach driver,$(call get-wifi-drivers),$($(driver)_modules)))\
$(if $(LOCAL_CONFIG_BUILD_MODULES),\
 $(if $(filter multiwifi,$(LOCAL_CONFIG_BUILD_MODULES)),,\
  $(foreach module,$(LOCAL_CONFIG_BUILD_MODULES),\
   $(if $(filter $(module),$(all_modules)),,\
    $(eval IGNORE_MODULES += $(module)))))\
)
endef

$(eval $(call ignored-drivers))
#$(warning  IGNORE_DRIVERS = $(IGNORE_DRIVERS))
WIFI_REAL_DRIVERS := $(filter-out $(IGNORE_DRIVERS),$(WIFI_BUILT_MODULES))
#$(warning WIFI_REAL_DRIVERS = $(WIFI_REAL_DRIVERS))

$(eval $(call ignored-modules))
#$(warning  IGNORE_MODULES = $(IGNORE_MODULES))
WIFI_REAL_MODULES := $(filter-out $(IGNORE_MODULES),$(CONFIG_WIFI_MODULES))
#$(warning WIFI_REAL_MODULES = $(WIFI_REAL_MODULES))

WIFI_BOTH_MODULES :=
define find-both-wifi-module
$(strip \
$(foreach driver1,$(WIFI_REAL_MODULES),\
   $(foreach driver2,$(WIFI_REAL_DRIVERS),\
      $(if $(filter $(driver1),$(driver2)), \
         $(eval WIFI_BOTH_MODULES += $(driver1)) \
      ) \
   ) \
))
endef

$(call find-both-wifi-module)
$(eval $(if $(filter multiwifi,$(LOCAL_CONFIG_BUILD_MODULES)), WIFI_BOTH_MODULES = $(WIFI_REAL_DRIVERS)))
$(warning $(BOARD) config wifi is :$(WIFI_BOTH_MODULES))

PYTHON_MODULE = [$(foreach m,$(WIFI_BOTH_MODULES),'$(m)',)]

ifeq ($(DRIVER_IN_KERNEL),true)
all:
	@echo "wifi_modules_list = $(PYTHON_MODULE)" > $(TOP_DIR)/common14-5.15/driver_modules/wifi_bt/wifi/configs/wifi_module_list.bzl
	@echo "$(MANUFACTURER)" > $(TOP_DIR)/common14-5.15/driver_modules/wifi_bt/wifi/configs/project.txt
else
all:
	@echo "wifi_modules_list = $(PYTHON_MODULE)" > $(TOP_DIR)/driver_modules/wifi_bt/wifi/configs/wifi_module_list.bzl
	@echo "$(MANUFACTURER)" > $(TOP_DIR)/driver_modules/wifi_bt/wifi/configs/project.txt
endif
