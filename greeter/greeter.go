package greeter

import (
	"fmt"

	coreiface "github.com/ipfs/kubo/core/coreiface"
	plugin "github.com/ipfs/kubo/plugin"
)

type GreeterPlugin struct{}

var _ plugin.PluginDaemon = (*GreeterPlugin)(nil)

// Name returns the plugin's name, satisfying the plugin.Plugin interface.
func (*GreeterPlugin) Name() string {
	return "greeter"
}

// Version returns the plugin's version, satisfying the plugin.Plugin interface.
func (*GreeterPlugin) Version() string {
	return "0.2.0"
}

// Init initializes plugin, satisfying the plugin.Plugin interface. Put any
// initialization logic here.
func (*GreeterPlugin) Init(env *plugin.Environment) error {
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
