package example

import (
	delaystore "github.com/ipfs/go-ipfs-example-plugin/delaystore"
	"gx/ipfs/QmUJYo4etAQqFfSS2rarFAE97eNGB8ej64YkRT2SmsYD4r/go-ipfs/plugin"
)

// Plugins is an exported list of plugins that will be loaded by go-ipfs.
var Plugins = []plugin.Plugin{
	&delaystore.DelaystorePlugin{},
}
