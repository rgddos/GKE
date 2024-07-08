terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.84.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}


provider "kubernetes" {
  host             = "https://${google_container_cluster.test_cluster.endpoint}"
  token            = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.test_cluster.master_auth.0.cluster_ca_certificate)
}


provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.test_cluster.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.test_cluster.master_auth.0.cluster_ca_certificate)
  }
}


