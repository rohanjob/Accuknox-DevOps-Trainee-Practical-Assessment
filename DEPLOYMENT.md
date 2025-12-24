# End-to-End Deployment Guide

This document outlines the steps to fully deploy and verify the Wisecow application using the artifacts in this repository.

## 1. Prerequisites
- A Kubernetes cluster (Minikube, Kind, or a Cloud Provider like GKE/EKS).
- `kubectl` installed and configured.
- Docker Hub account (or any other container registry).

## 2. GitHub Actions Setup (Secrets)
To enable the automated CI/CD pipeline, you must add the following secrets to your GitHub repository (**Settings > Secrets and variables > Actions**):

| Secret Name | Description |
| ----------- | ----------- |
| `DOCKERHUB_USERNAME` | Your Docker Hub username. |
| `DOCKERHUB_TOKEN` | Your Docker Hub Access Token (PAT). |
| `KUBECONFIG` | The contents of your `~/.kube/config` file to allow GitHub to access your cluster. |

## 3. Manual Deployment (For Testing)
If you wish to deploy manually without CI/CD:

```bash
# 1. Build and Push Image
docker build -t your-username/wisecow:latest ./PS1
docker push your-username/wisecow:latest

# 2. Update Kubernetes Manifests
# Edit PS1/k8s/deployment.yaml and update the image field.

# 3. Apply Manifests
kubectl apply -f PS1/k8s/
```

## 4. Verifying TLS (Problem Statement 1)
The application assumes you have `cert-manager` and an Ingress Controller (like Nginx) installed.
- Check Ingress status: `kubectl get ingress wisecow-ingress`
- Check Certificate status: `kubectl get certificate wisecow-tls`

## 5. Running Health Scripts (Problem Statement 2)
- **System Monitoring**: `bash PS2/system_health.sh`
- **App Health**: `python PS2/app_health_checker.py <APPLICATION_URL>`

## 6. Applying Security Policies (Problem Statement 3)
Ensure KubeArmor is installed in your cluster:
```bash
curl -sfL https://raw.githubusercontent.com/kubearmor/KubeArmor/main/install.sh | bash
kubectl apply -f PS3/kubearmor_policy.yaml
```

## 7. Verification Results
The application provides a "Cowsay" response on port 4499.
Example verify command:
```bash
curl http://<INGRESS_IP>/
```
