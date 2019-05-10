package greeter

import (
	"fmt"

	plugin "github.com/ipfs/go-ipfs/plugin"
	coreiface "github.com/ipfs/interface-go-ipfs-core"
)

type GreeterPlugin struct{}

var _ plugin.PluginDaemon = (*GreeterPlugin)(nil)

// Name returns the plugin's name, satisfying the plugin.Plugin interface.
func (*GreeterPlugin) Name() string {
	return "greeter"
}

// Version returns the plugin's version, satisfying the plugin.Plugin interface.
func (*GreeterPlugin) Version() string {
	return "0.1.0"
}

// Init initializes plugin, satisfying the plugin.Plugin interface. Put any
// initialization logic here.
func (*GreeterPlugin) Init() error {
	return nil
}

func (*GreeterPlugin) Start(_ coreiface.CoreAPI) error {
	fmt.Println("Hello!")
	return nil
}

func (*GreeterPlugin) Close() error {
	fmt.Println("Goodbye!")
	return nil
}
