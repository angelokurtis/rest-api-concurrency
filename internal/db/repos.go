package db

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

type ClusterRepository interface {
	CreateCluster(ctx context.Context, arg CreateClusterParams) (*Cluster, error)
	DeleteCluster(ctx context.Context, id pgtype.UUID) error
	GetCluster(ctx context.Context, id pgtype.UUID) (*Cluster, error)
	ListClusters(ctx context.Context) ([]*Cluster, error)
	UpdateCluster(ctx context.Context, arg UpdateClusterParams) (*Cluster, error)
}

var _ ClusterRepository = (*Queries)(nil)
