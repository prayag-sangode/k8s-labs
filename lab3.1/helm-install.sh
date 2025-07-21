#!/bin/bash

# Download Helm installation script
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# Make the script executable
chmod 700 get_helm.sh

# Run the script to install Helm
./get_helm.sh

# Verify the installation
helm version
