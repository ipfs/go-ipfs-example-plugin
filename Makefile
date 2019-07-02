# Force Go Modules
GO111MODULE = on

GOCC ?= go
GOFLAGS ?=

# make reproducable
GOFLAGS += -asmflags=all=-trimpath="$(GOPATH)" -gcflags=all=-trimpath="$(GOPATH)"

# If set, override the install location for plugins
IPFS_PATH ?= $(HOME)/.ipfs

# If set, override the IPFS version to build against. This _modifies_ the local
# go.mod/go.sum files and permanently sets this version.
IPFS_VERSION ?= $(lastword $(shell $(GOCC) list -m github.com/ipfs/go-ipfs))

.PHONY: install build

go.mod: FORCE
	./set-target.sh $(IPFS_VERSION)

FORCE:

example-plugin.so: plugin.go go.mod
	$(GOCC) build $(GOFLAGS) -buildmode=plugin -o "$@" "$<"
	chmod +x "$@"

build: example-plugin.so
	@echo "Built against" $(IPFS_VERSION)

install: build
	mkdir -p "$(IPFS_PATH)/plugins/"
	cp -f example-plugin.so "$(IPFS_PATH)/plugins/example-plugin.so"
