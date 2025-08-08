package main

import (
	"github.com/google/wire"
	pgx "github.com/jackc/pgx/v5"

	"github.com/angelokurtis/rest-api-concurrency/internal/db"
	"github.com/angelokurtis/rest-api-concurrency/internal/httpserver"
	"github.com/angelokurtis/rest-api-concurrency/internal/term"
	"github.com/angelokurtis/rest-api-concurrency/pkg/app"
)

//nolint:unused // This function is used during compile-time to generate code for dependency injection
var providers = wire.NewSet(
	httpserver.Providers,
	db.Providers,
	term.Providers,
	wire.Bind(new(db.DBTX), new(*pgx.Conn)),
	wire.Bind(new(db.Querier), new(*db.Queries)),
	wire.Bind(new(Runner), new(*app.Runner)),
	wire.Bind(new(term.Renderer), new(*term.MarkdownRenderer)),
	wire.Struct(new(app.Runner), "*"),
)
