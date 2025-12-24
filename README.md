# Wisecow Application - DevOps Project

This repository contains the Wisecow application, containerized and prepared for Kubernetes deployment with a full CI/CD pipeline, security policies, and health monitoring scripts.

## Problem Statement 1: Containerization and Deployment ([PS1](./PS1))

### 1. Dockerization
The application is containerized using the [Dockerfile](./PS1/Dockerfile). It uses an Ubuntu base image and installs `fortune-mod`, `cowsay`, and `netcat`.

To build and run locally:
```bash
cd PS1
docker build -t wisecow .
docker run -p 4499:4499 wisecow
```

### 2. Kubernetes Deployment
Kubernetes manifests are located in the [PS1/k8s](./PS1/k8s) directory:
- `deployment.yaml`: Deploys the wisecow pods.
- `service.yaml`: Exposes the application internally.
- `ingress.yaml`: Provides external access with TLS termination.

To deploy:
```bash
kubectl apply -f PS1/k8s/
```

### 3. CI/CD Pipeline
A GitHub Actions workflow is defined in [PS1/.github/workflows/ci-cd.yml](./PS1/.github/workflows/ci-cd.yml). It automates:
- Building the Docker image.
- Pushing the image to Docker Hub.
- Deploying the updated image to the Kubernetes cluster.

### 4. TLS Implementation
TLS is handled via the Kubernetes Ingress resource. It is configured to use `cert-manager` with Let's Encrypt for automatic certificate management.

---

## Problem Statement 2: Scripting Challenges ([PS2](./PS2))

### 1. System Health Monitoring ([system_health.sh](./PS2/system_health.sh))
A Bash script that monitors:
- CPU Usage
- Memory Usage
- Disk Space
- Running Processes
It alerts the console and logs to `system_health.log` if thresholds (>80%) are exceeded.

### 2. Application Health Checker ([app_health_checker.py](./PS2/app_health_checker.py))
A Python script that checks the HTTP status of an application.
Usage:
```bash
python PS2/app_health_checker.py http://localhost:4449
```

---

## Problem Statement 3: Zero-Trust Security ([PS3](./PS3))

### KubeArmor Policy ([kubearmor_policy.yaml](./PS3/kubearmor_policy.yaml))
A zero-trust security policy for the Wisecow workload. It restricts:
- Executables allowed to run (bash, nc, fortune, cowsay).
- File system access.
- Network communication.

Apply the policy:
```bash
kubectl apply -f PS3/kubearmor_policy.yaml
```
