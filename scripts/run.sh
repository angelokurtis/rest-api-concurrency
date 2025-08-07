#!/usr/bin/env bash

# Load the .env file
set -a
source .env
set +a

set -euo pipefail

go run ./cmd/app/
