# Terraform Setup for Private GKE Cluster and Node Pool Creation

## Overview

This Terraform module automates the creation of a private Google Kubernetes Engine (GKE) cluster and node pool across multiple environments. It also supports the installation of various add-ons using Helm, based on provided inputs.

### Supported Add-Ons

- **Nginx Ingress Controller**
- **Cert Manager**
- **Redis**
- **ArgoCD**
- **External Secrets Manager**

## Prerequisites

Before using this Terraform module, ensure you have:

- Google Cloud Platform (GCP) account with appropriate permissions.
- Terraform CLI installed locally.

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/rgddos/GKE

2. Initailize Terraform

   ```bash
   terraform init

**Note:** State files will be created inside the `terrafrm-state` folder.


3. Customize the `env/tfvars` and `files/yaml` files.

4. Run Terraform plan and apply to create the GKE cluster and node pool with ADD-ONs.