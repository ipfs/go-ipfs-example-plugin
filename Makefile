# Force Go Modules
GO111MODULE = on

GOCC ?= go
GOFLAGS ?=

# If set, override the install location for plugins
IPFS_PATH ?= $(HOME)/.ipfs
# Just to inform the user which kubo-version go.mod uses.
IPFS_VERSION = $(lastword $(shell $(GOCC) list -m github.com/ipfs/kubo))

GOFLAGS += -trimpath

.PHONY: install build

FORCE:

example-plugin.so: main/main.go go.mod
	$(GOCC) build $(GOFLAGS) -buildmode=plugin -o "$@" "$<"
	chmod +x "$@"

build: example-plugin.so
	@echo "Built against" $(IPFS_VERSION)

install: build
	mkdir -p "$(IPFS_PATH)/plugins/"
	cp -f example-plugin.so "$(IPFS_PATH)/plugins/example-plugin.so"
