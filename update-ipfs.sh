#!/bin/bash

set -eo pipefail

GOPATH="$(go env GOPATH)"
VERSION="${1:-latest}"
PKG=github.com/ipfs/go-ipfs

# Resolve the exact version/package name
read PKG VERSION < <(go list -m "$PKG@$VERSION")

# Update to that version.
go get $PKG@$VERSION

FLAGS=()
while read pkg ver; do
    FLAGS+=("-require=$pkg@$ver")
done < <( (cd "$GOPATH/pkg/mod/$PKG@$VERSION" && go list -m all | tail -n+2) )

go mod edit ${FLAGS[*]}
go mod tidy
