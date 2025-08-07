CREATE
EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE clusters
(
    id         UUID PRIMARY KEY   DEFAULT gen_random_uuid(),
    name       TEXT      NOT NULL,
    version    TEXT      NOT NULL,
    provider   TEXT      NOT NULL,
    region     TEXT      NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
