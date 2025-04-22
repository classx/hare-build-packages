# build Hare
SHELL=/bin/bash
VERBOSE ?= FALSE
WORK_DIR ?= $(CURDIR)
OUTPUT_DIR ?= $(WORK_DIR)/output
PACKAGE_TYPE ?= deb

# Hide or not the calls depending of VERBOSE
ifeq ($(VERBOSE),TRUE)
	HIDE =
else
	HIDE = @
endif

.PHONY: help clean init build archive

help:
	@echo "Help"

clean:
	$(HIDE)rm -rf $(OUTPUT_DIR)
	$(HIDE)rm -rf harec/config.mk hare/config.mk

init: clean
	$(HIDE)git submodule update --init --recursive
	$(HIDE)mkdir -p $(OUTPUT_DIR)
	$(HIDE)cp -f harec/configs/linux.mk harec/config.mk
	$(HIDE)cp -f hare/configs/linux.mk hare/config.mk

build: init
	$(HIDE)docker build -t hare:builder -f Dockerfile.$(PACKAGE_TYPE) .

archive: build
	$(HIDE)docker run --rm -v $(OUTPUT_DIR):/output hare:builder /bin/bash -c "cp -r /src/* /output"
	$(HIDE)ls -l $(OUTPUT_DIR)


