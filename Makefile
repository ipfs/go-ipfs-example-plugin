GOCC ?= go

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
	$(GOCC) build -buildmode=plugin -i -o "$@" "$<"
	chmod +x "$@"

build: example-plugin.so
	@echo "Built against" $(IPFS_VERSION)

install: build
	install -Dm700 example-plugin.so "$(IPFS_PATH)/plugins/example-plugin.so"
