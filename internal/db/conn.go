package db

import (
	"context"
	"fmt"
	"log/slog"
	"os"

	pgx "github.com/jackc/pgx/v5"

	"github.com/angelokurtis/rest-api-concurrency/internal/errors"
)

func NewConnection(ctx context.Context) (*pgx.Conn, func(), error) {
	cleanup := func() {}

	database := os.Getenv("POSTGRES_DB")
	user := os.Getenv("POSTGRES_USER")
	password := os.Getenv("POSTGRES_PASSWORD")

	conn, err := pgx.Connect(ctx, fmt.Sprintf("postgres://%s:%s@localhost:5432/%s?sslmode=disable", user, password, database))
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
