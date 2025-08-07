package httpserver

import (
	"github.com/google/wire"
)

var Providers = wire.NewSet(
	NewServeMux,
)
