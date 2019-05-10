GOCC ?= go
IPFS_PATH ?= $(HOME)/.ipfs

.PHONY: install build

build: example-plugin.so
	@echo "Built against" $(shell $(GOCC) list -m github.com/ipfs/go-ipfs)

install: build
	install -Dm700 example-plugin.so "$(IPFS_PATH)/plugins/example-plugin.so"

example-plugin.so: plugin.go
	$(GOCC) build -buildmode=plugin -i -o "$@" "$<"
	chmod +x "$@"
