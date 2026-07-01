#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "Applying Kubernetes manifests..."
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml

echo "Waiting for deployment rollout..."
kubectl rollout status deployment/portfolio -n devops --timeout=300s

echo "Current service status:"
kubectl get svc portfolio-service -n devops
