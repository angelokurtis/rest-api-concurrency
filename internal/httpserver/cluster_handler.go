package httpserver

import (
	"encoding/json"
	"net/http"
	"time"

	"github.com/google/uuid"
)

type ClusterHandler struct{}

func (h *ClusterHandler) CreateCluster(w http.ResponseWriter, r *http.Request) {
	var input Cluster
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		http.Error(w, "invalid JSON", http.StatusBadRequest)
		return
	}

	input.ID = uuid.New()
	now := time.Now()
	input.CreatedAt = now
	input.UpdatedAt = now

	//cluster := h.Store.Create(input)
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(cluster)
}

func (h *ClusterHandler) GetCluster(w http.ResponseWriter, r *http.Request) {
	idStr := r.PathValue("id")
	id, err := uuid.Parse(idStr)
	if err != nil {
		http.Error(w, "invalid UUID", http.StatusBadRequest)
		return
	}

	cluster, ok := h.Store.Get(id)
	if !ok {
		http.NotFound(w, r)
		return
	}

	json.NewEncoder(w).Encode(cluster)
}

func (h *ClusterHandler) ListClusters(w http.ResponseWriter, r *http.Request) {
	clusters := h.Store.List()
	json.NewEncoder(w).Encode(clusters)
}

func (h *ClusterHandler) UpdateCluster(w http.ResponseWriter, r *http.Request) {
	idStr := r.PathValue("id")
	id, err := uuid.Parse(idStr)
	if err != nil {
		http.Error(w, "invalid UUID", http.StatusBadRequest)
		return
	}

	var input Cluster
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		http.Error(w, "invalid JSON", http.StatusBadRequest)
		return
	}

	updated, err := h.Store.Update(id, input)
	if err != nil {
		http.NotFound(w, r)
		return
	}

	json.NewEncoder(w).Encode(updated)
}

func (h *ClusterHandler) DeleteCluster(w http.ResponseWriter, r *http.Request) {
	idStr := r.PathValue("id")
	id, err := uuid.Parse(idStr)
	if err != nil {
		http.Error(w, "invalid UUID", http.StatusBadRequest)
		return
	}

	ok := h.Store.Delete(id)
	if !ok {
		http.NotFound(w, r)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
