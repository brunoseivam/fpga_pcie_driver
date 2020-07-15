# Set your cross compile prefix with CROSS_COMPILE variable
CROSS_COMPILE ?=

CMDSEP = ;

CC =            $(CROSS_COMPILE)gcc
AR =            $(CROSS_COMPILE)ar
LD =            $(CROSS_COMPILE)ld
OBJDUMP =       $(CROSS_COMPILE)objdump
OBJCOPY =       $(CROSS_COMPILE)objcopy
SIZE =          $(CROSS_COMPILE)size
MAKE =          make

DRIVER_DIR = drivers/pcie
LIB_DIR = lib/pcie

PREFIX ?= /usr

VERSION := $(shell ./version.sh)

all: kernel_driver lib_driver

.PHONY: kernel_driver lib_driver install uninstall clean

kernel_driver: core_driver

kernel_driver_clean: core_driver_clean

kernel_driver_install: core_driver_install etc_driver_install

kernel_driver_uninstall: core_driver_uninstall etc_driver_uninstall

core_driver:
	$(MAKE) -C $(DRIVER_DIR) VERSION=$(VERSION) all

core_driver_clean:
	$(MAKE) -C $(DRIVER_DIR) VERSION=$(VERSION) clean

core_driver_install:
	$(MAKE) -C $(DRIVER_DIR) PREFIX=$(PREFIX) VERSION=$(VERSION) core_install

core_driver_uninstall:
	$(MAKE) -C $(DRIVER_DIR) PREFIX=$(PREFIX) VERSION=$(VERSION) core_uninstall

etc_driver_install:
	$(MAKE) -C $(DRIVER_DIR) PREFIX=$(PREFIX) VERSION=$(VERSION) etc_install

etc_driver_uninstall:
	$(MAKE) -C $(DRIVER_DIR) PREFIX=$(PREFIX) VERSION=$(VERSION) etc_uninstall

lib_driver:
	$(MAKE) -C $(LIB_DIR) VERSION=$(VERSION) all

lib_driver_clean:
	$(MAKE) -C $(LIB_DIR) VERSION=$(VERSION) clean

lib_driver_install:
	$(MAKE) -C $(LIB_DIR) PREFIX=$(PREFIX) VERSION=$(VERSION) install

lib_driver_uninstall:
	$(MAKE) -C $(LIB_DIR) PREFIX=$(PREFIX) VERSION=$(VERSION) uninstall

clean: kernel_driver_clean lib_driver_clean

install: kernel_driver_install lib_driver_install

uninstall: kernel_driver_uninstall lib_driver_uninstall
