package postgres

import (
	"context"
	"log/slog"
	"os"

	pgx "github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"

	"github.com/angelokurtis/rest-api-concurrency/internal/errors"
)

func NewConnection(ctx context.Context) (*pgx.Conn, func(), error) {
	cleanup := func() {}

	conn, err := pgx.ConnectConfig(ctx, &pgx.ConnConfig{Config: pgconn.Config{
		Database: os.Getenv("POSTGRES_DB"),
		User:     os.Getenv("POSTGRES_USER"),
		Password: os.Getenv("POSTGRES_PASSWORD"),
	}})
	if err != nil {
		return nil, cleanup, errors.WithStack(err)
	}

	cleanup = func() {
		if cerr := conn.Close(ctx); cerr != nil {
			slog.WarnContext(ctx, "error closing connection")
		}
	}

	return conn, cleanup, nil
}
