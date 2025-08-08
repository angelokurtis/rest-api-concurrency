package httpserver

import (
	"github.com/google/uuid"
	"time"
)

type Cluster struct {
	ID        uuid.UUID `json:"id"`
	Name      string    `json:"name"`
	Version   string    `json:"version"`
	Provider  string    `json:"provider"`
	Region    string    `json:"region"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}
