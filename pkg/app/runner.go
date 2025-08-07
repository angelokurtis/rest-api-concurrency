package app

import (
	"context"

	"github.com/angelokurtis/rest-api-concurrency/internal/errors"
	"github.com/angelokurtis/rest-api-concurrency/internal/postgres"
	"github.com/angelokurtis/rest-api-concurrency/internal/term"
)

type Runner struct {
	term.Renderer
	postgres.Querier
}

func (r *Runner) Run(ctx context.Context) error {
	clusters, err := r.ListClusters(ctx)
	if err != nil {
		return errors.WithStack(err)
	}

	return r.RenderYAML(clusters)
}
