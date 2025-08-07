INSERT INTO clusters (name, version, provider, region)
VALUES ('dev-cluster', 'v1.29.1', 'kind', 'local'),
       ('prod-cluster', 'v1.28.3', 'EKS', 'us-east-1'),
       ('test-cluster', 'v1.27.5', 'GKE', 'europe-west1'),
       ('staging-cluster', 'v1.28.0', 'AKS', 'centralus'),
       ('legacy-cluster', 'v1.24.7', 'EKS', 'us-west-2'),
       ('ml-training-cluster', 'v1.29.0', 'GKE', 'us-central1'),
       ('sandbox-cluster', 'v1.26.6', 'kind', 'local'),
       ('br-prod-cluster', 'v1.33.0', 'TKS', 'tesp03'),
       ('eu-prod-cluster', 'v1.28.4', 'AKS', 'northeurope'),
       ('asia-dev-cluster', 'v1.27.3', 'EKS', 'ap-northeast-1'),
       ('infra-cluster', 'v1.29.2', 'GKE', 'us-east1');
