-- name: CreateCluster :one
INSERT INTO clusters (name, api_server_url, token)
VALUES ($1, $2, $3)
    RETURNING *;

-- name: GetCluster :one
SELECT * FROM clusters WHERE id = $1;

-- name: ListClusters :many
SELECT * FROM clusters ORDER BY created_at DESC;

-- name: UpdateCluster :one
UPDATE clusters
SET name = $2, api_server_url = $3, token = $4, updated_at = now()
WHERE id = $1
    RETURNING *;

-- name: DeleteCluster :exec
DELETE FROM clusters WHERE id = $1;
