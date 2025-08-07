-- name: CreateCluster :one
INSERT INTO clusters (name, version, provider, region)
VALUES ($1, $2, $3, $4) RETURNING *;

-- name: GetCluster :one
SELECT *
FROM clusters
WHERE id = $1;

-- name: ListClusters :many
SELECT *
FROM clusters
ORDER BY created_at DESC;

-- name: UpdateCluster :one
UPDATE clusters
SET name       = $2,
    version    = $3,
    provider   = $4,
    region     = $5,
    updated_at = now()
WHERE id = $1 RETURNING *;

-- name: DeleteCluster :exec
DELETE
FROM clusters
WHERE id = $1;
