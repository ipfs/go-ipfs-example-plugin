package main

import (
	example "github.com/ipfs/go-ipfs-example-plugin"
)

// Plugins is an exported list of plugins that will be loaded by go-ipfs.
var Plugins = example.Plugins
