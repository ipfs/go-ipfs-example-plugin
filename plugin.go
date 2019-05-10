package main

import (
	delaystore "github.com/ipfs/go-ipfs-example-plugin/delaystore"
	"github.com/ipfs/go-ipfs/plugin"
)

// Plugins is an exported list of plugins that will be loaded by go-ipfs.
var Plugins = []plugin.Plugin{
	&delaystore.DelaystorePlugin{},
}
