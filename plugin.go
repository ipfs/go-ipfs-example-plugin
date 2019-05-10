package main

import (
	"github.com/ipfs/go-ipfs/plugin"

	delaystore "github.com/ipfs/go-ipfs-example-plugin/delaystore"
	greeter "github.com/ipfs/go-ipfs-example-plugin/greeter"
)

// Plugins is an exported list of plugins that will be loaded by go-ipfs.
var Plugins = []plugin.Plugin{
	&delaystore.DelaystorePlugin{},
	&greeter.GreeterPlugin{},
}
