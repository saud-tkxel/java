#!/bin/bash

# Update Helm dependencies
helm dependency update ./helm/myapp

# Install or upgrade the Helm release
helm upgrade --install myapp ./helm/myapp --namespace default --create-namespace
