#!/usr/bin/env bash

set -xe

rm -rf go.tools.mod go.tools.sum
go mod init github.com/angelokurtis/rest-api-concurrency/tools -modfile=go.tools.mod
