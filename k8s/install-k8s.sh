#!/bin/bash

set -e

echo "🔧 Installing Kubernetes CLI tools: kind, kubectl, and helm..."
# -------------------
# Install K3s cluster && Kubectl
# -------------------
sudo apt update && sudo apt upgrade -y
curl -sfL https://get.k3s.io | sh -
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
source ~/.bashrc

#Install kubectl

# Variables
VERSION="v1.30.0"
URL="https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
INSTALL_DIR="/usr/local/bin"

# Download and install kubectl
curl -LO "$URL"
chmod +x kubectl
sudo mv kubectl $INSTALL_DIR/
kubectl version --client

# Clean up
rm -f kubectl

echo "kubectl installation complete."

echo "k3s cluster & kubectl installation complete."

# -------------------
# Install Helm
# -------------------
echo "📦 Installing Helm..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
echo "✅ Helm installed: $(helm version --short)"

echo "🎉 All tools installed successfully!"
