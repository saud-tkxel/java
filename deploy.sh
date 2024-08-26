#!/bin/bash

set -e

HELM_CHART_PATH="./helm/myapp"
RELEASE_NAME="myapp"
NAMESPACE="demo-app" 

if ! command -v helm &> /dev/null; then
    echo "Helm could not be found. Please install Helm."
    exit 1
fi


echo "Updating Helm dependencies..."
helm dependency update "$HELM_CHART_PATH"

if ! kubectl get namespace "$NAMESPACE" &> /dev/null; then
    echo "Namespace '$NAMESPACE' does not exist. Creating it..."
    kubectl create namespace "$NAMESPACE"
fi


echo "Installing or upgrading Helm release..."
helm upgrade --install "$RELEASE_NAME" "$HELM_CHART_PATH" --namespace "$NAMESPACE"


if ! kubectl get pods -n ingress-nginx | grep -q "nginx-ingress-controller"; then
    echo "NGINX Ingress Controller not found. Installing..."
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
fi
kubectl rollout restart deployment myapp-deployment -n demo-app
echo "Deployment complete."
