package main

import (
	"github.com/google/wire"
	pgx "github.com/jackc/pgx/v5"

	"github.com/angelokurtis/rest-api-concurrency/internal/db"
	"github.com/angelokurtis/rest-api-concurrency/internal/httpserver"
	"github.com/angelokurtis/rest-api-concurrency/internal/term"
	"github.com/angelokurtis/rest-api-concurrency/pkg/app"
)

var providers = wire.NewSet(
	db.Providers,
	httpserver.Providers,
	term.Providers,
	wire.Bind(new(db.ClusterRepository), new(*db.Queries)),
	wire.Bind(new(db.DBTX), new(*pgx.Conn)),
	wire.Bind(new(Runner), new(*app.Runner)),
	wire.Bind(new(term.Renderer), new(*term.MarkdownRenderer)),
	wire.Struct(new(app.Runner), "*"),
)
