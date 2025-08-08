package app

import (
	"context"

	"github.com/angelokurtis/rest-api-concurrency/internal/db"
	"github.com/angelokurtis/rest-api-concurrency/internal/errors"
	"github.com/angelokurtis/rest-api-concurrency/internal/term"
)

type Runner struct {
	term.Renderer
	db.ClusterRepository
}

func (r *Runner) Run(ctx context.Context) error {
	clusters, err := r.ListClusters(ctx)
	if err != nil {
		return errors.WithStack(err)
	}

	return r.RenderYAML(clusters)
}
