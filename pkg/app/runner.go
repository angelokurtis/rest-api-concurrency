package app

import (
	"context"
	"github.com/angelokurtis/rest-api-concurrency/internal/errors"
	"github.com/angelokurtis/rest-api-concurrency/internal/postgres"
)

type Runner struct {
	PostgreSQL postgres.Querier
}

func (r *Runner) Run(ctx context.Context) error {
	return errors.New("not implemented")
}
