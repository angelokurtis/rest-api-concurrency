package main

import (
	"github.com/google/wire"

	"github.com/angelokurtis/rest-api-concurrency/internal/term"
	"github.com/angelokurtis/rest-api-concurrency/pkg/app"
)

//nolint:unused // This function is used during compile-time to generate code for dependency injection
var providers = wire.NewSet(
	term.Providers,
	wire.Bind(new(Runner), new(*app.Runner)),
	wire.Bind(new(term.Renderer), new(*term.MarkdownRenderer)),
	wire.Struct(new(app.Runner), "*"),
)
