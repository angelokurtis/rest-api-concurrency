#!/usr/bin/env bash

set -euo pipefail

# Initialize a new Go module for tools
rm -rf tools.mod tools.sum
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
go mod init github.com/angelokurtis/rest-api-concurrency/tools
mv go.mod "$OLDPWD/tools.mod"
cd "$OLDPWD"
rm -rf "$TMP_DIR"

# Install tools
set -x
go get -modfile=tools.mod -tool -u github.com/google/wire/cmd/wire
