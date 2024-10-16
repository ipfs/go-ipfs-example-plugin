# go-ipfs-example-plugin

[![](https://img.shields.io/badge/made%20by-Protocol%20Labs-blue.svg?style=flat-square)](https://protocol.ai)
[![](https://img.shields.io/badge/project-IPFS-blue.svg?style=flat-square)](https://ipfs.io/)
[![](https://img.shields.io/badge/freenode-%23ipfs-blue.svg?style=flat-square)](http://webchat.freenode.net/?channels=%23ipfs)
[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)
[![GoDoc](https://godoc.org/github.com/ipfs/go-ipfs-example-plugin?status.svg)](https://godoc.org/github.com/ipfs/go-ipfs-example-plugin)

> example plugin for Kubo

This repository contains a set of example Kubo plugins, demonstrating how to integrate external plugins into Kubo.

Packages:

* delaystore: an example datastore plugin that wraps an inner datastore in a "delayed" datastore.
* greeter: an example daemon plugin that prints "Hello!" on start and "Goodbye!" on exit.

**NOTE 1:** Plugins only work on Linux and MacOS at the moment. You can track the progress of this issue here: https://github.com/golang/go/issues/19282. MacOS users will need to compile Kubo themselves too, as official MacOS releases of Kubo are cross-compiled and do not support loading plugins. Also, only amd64 architecture is supported.

**NOTE 2:** This plugin exists as an *example* and a starting point for new plugins. It isn't particularly useful by itself.

## Building and Installing

Go plugin system is very whiny. The following constellation need to align:

* You need to be using the same Go version to compile Kubo and the plugin. Upstream releases of Kubo use [whatever it says here](https://github.com/ipfs/distributions/blob/master/.tool-versions#L2). If using an existing version of Kubo, check what version of golang is was built with using the command `ipfs version --all`.
* The dependencies in go.mod need to be exactly the same as in the Kubo version that we want the plugin to work with. In this example, the following need to be the same as in [Kubo's go.mod](https://github.com/ipfs/kubo/blob/master/go.mod):
  * github.com/ipfs/go-datastore
  * github.com/ipfs/go-ipfs-delay
  * github.com/ipfs/kubo
* There are additional considerations with -trimpath etc (see below).
* Failure to do so will cause errors when loading the plugin.


### Using official Kubo releases

As provided the plugin is designed to work with a default version (whatever is used in the [go.mod](go.mod) file). You can use:

```
make build
make install
```

to build and install this version.

If you want to upgrade or use a different official release of Kubo:

  1. `go get github.com/ipfs/kubo@<version>`
  2. Verify `datastore` and other dependencies are aligned with the version of Kubo. Otherwise set the right versions manually.
  3. `go mod tidy`.

In some cases, fully removing the second, "indirect requires" block in `go.mod` and running `go mod tidy` will fix wrong indirect requires.

### Using local Kubo builds

This is more tricky.

  1. Ensure full dependency alignment
  2. If you are building Kubo somewhere else (on a different computer), ensure it is built using `-trimpath` when doing `go build` (i.e. `go build -trimpath`)
  3. You may need to build the plugin using `-trimpath` or not, depending on how you are building the Kubo binary and where. i.e. you can use a `replace` directive in go.mod to point to a local version of Kubo and then it is possibly fine to build the plugin and Kubo without `trimpath` altogether.

If Go versions and dependencies are aligned, usually errors have to do with `-trimpath` stuff. You can also try `-asmflags=all=-trimpath="$(GOPATH)" -gcflags=all=-trimpath="$(GOPATH)"` and setting $(GOPATH) to what `go env` says etc. and try to get both the plugin and Kubo binaries to reference modules with exactly the same paths.

## Contribute

Feel free to join in. All welcome. Open an [issue](https://github.com/ipfs/go-ipfs-example-plugin/issues)!

This repository falls under the IPFS [Code of Conduct](https://github.com/ipfs/community/blob/master/code-of-conduct.md).

### Want to hack on IPFS?

[![](https://cdn.rawgit.com/jbenet/contribute-ipfs-gif/master/img/contribute.gif)](https://github.com/ipfs/community/blob/master/CONTRIBUTING.md)

## License

MIT
