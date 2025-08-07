CREATE
EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE clusters
(
    id             UUID PRIMARY KEY   DEFAULT gen_random_uuid(),
    name           TEXT      NOT NULL,
    api_server_url TEXT      NOT NULL,
    token          TEXT      NOT NULL,
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
