GOFLAGS ?=

# If set, override the install location for plugins
IPFS_PATH ?= $(HOME)/.ipfs
# Just to inform the user which kubo-version go.mod uses.
IPFS_VERSION = $(lastword $(shell go list -m github.com/ipfs/kubo))

GOFLAGS += -trimpath

.PHONY: install build

FORCE:

example-plugin.so: main/main.go go.mod
	CGO_ENABLED=1 go build $(GOFLAGS) -buildmode=plugin -o "$@" "$<"
	chmod +x "$@"

build: example-plugin.so
	@echo "Built against" $(IPFS_VERSION)

install: build
	mkdir -p "$(IPFS_PATH)/plugins/"
	cp -f example-plugin.so "$(IPFS_PATH)/plugins/example-plugin.so"

clean:
	rm -f example-plugin.so

uninstall:
	rm -f "$(IPFS_PATH)/plugins/example-plugin.so"
	rmdir "$(IPFS_PATH)/plugins/" 2>/dev/null
