#!/bin/bash

# Set your variables
AKS_CLUSTER_NAME="my-aks-cluster"   # Replace with your AKS cluster name
AKS_RESOURCE_GROUP="my-aks-rg"      # Replace with your resource group name
DOCKER_IMAGE="${DOCKER_USERNAME}/my-python-app:latest"  # Your Docker Hub image name
K8S_DEPLOYMENT_NAME="my-python-app"  # Replace with your Kubernetes Deployment name
NAMESPACE="default"                 # Set the Kubernetes namespace (can be default or your specific namespace)

# Login to Azure
echo "Logging into Azure..."
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# Get AKS credentials for kubectl
echo "Getting credentials for AKS..."
az aks get-credentials --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME

# Pull the Docker image from Docker Hub
echo "Pulling Docker image from Docker Hub..."
docker pull $DOCKER_IMAGE

# Update the Kubernetes deployment with the new Docker image
echo "Updating Kubernetes deployment..."
kubectl set image deployment/$K8S_DEPLOYMENT_NAME $K8S_DEPLOYMENT_NAME=$DOCKER_IMAGE --namespace $NAMESPACE

echo "Deployment to AKS is successful!"
