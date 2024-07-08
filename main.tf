# Kubernetes Cluster
data "google_client_config" "default" {}



resource "google_container_cluster" "test_cluster" {
  project                  = var.project
  location                 = var.zone
  name                     = var.gke_cluster_name
  min_master_version       = var.gke_cluster_version
  network                  = var.network_name
  remove_default_node_pool = true
  initial_node_count       = 1
  networking_mode          = "VPC_NATIVE"


  cluster_autoscaling {
    enabled = false
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.cluster_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }


  private_cluster_config {
    enable_private_nodes   = var.enable_private_nodes
    master_ipv4_cidr_block = var.master_ipv4_cidr_block
  }

  release_channel {
    channel = "UNSPECIFIED"
  }
  maintenance_policy {
    daily_maintenance_window {
      start_time = "20:00"
    }
  }
}

# Kubernetes Node-pool
resource "google_container_node_pool" "pool_1" {
  cluster           = var.gke_cluster_name
  location          = var.zone
  max_pods_per_node = 110
  version = var.node_pool_version
  name              = "pool-1"
  node_count         = 5
  node_locations = var.node_locations
  project        = var.project

  management {
    auto_repair  = "false"
    auto_upgrade = "false"
  }
 
  node_config {
    disk_size_gb = 100
    disk_type    = "pd-standard"
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-standard-2"
  }
  depends_on = [google_container_cluster.test_cluster]
}


resource "kubernetes_namespace" "namespace" {
  count = length(var.namespace_names)
  metadata {
    name = var.namespace_names[count.index]
  }
   depends_on = [google_container_cluster.test_cluster, google_container_node_pool.pool_1]
}



#ADD-ONs

resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.7.0"
  namespace  = "ingress-nginx"
  timeout    = 3600

  values = [
    "${file("../files/ingress-nginx-values.yaml")}"
  ]
  depends_on = [kubernetes_namespace.namespace]
}

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.12.0"
  namespace  = "cert-manager"
  timeout    = 3600

  values = [
    "${file("../files/cert-manager-values.yaml")}"
  ]
  depends_on = [kubernetes_namespace.namespace]
}

resource "helm_release" "redis" {
  count = var.create_redis ? 1 : 0
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "18.0.1"
  namespace  = "redis"
  timeout    = 3500

  values = [
    "${file("../files/redis-values.yaml")}"
  ]
  depends_on = [kubernetes_namespace.namespace]
}



resource "helm_release" "argo-cd" {
  count = var.create_argo-cd ? 1 : 0
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.2"
  namespace  = "argocd"
  timeout    = 3500

  values = [
    "${file("../files/argocd-values.yaml")}"
  ]
  depends_on = [kubernetes_namespace.namespace]
}

resource "helm_release" "external-secrets" {
  count = var.create_external-secrets ? 1 : 0
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.9.5"
  namespace  = "external-secrets"
  timeout    = 3500

  values = [
    "${file("../files/external-secrets-values.yaml")}"
  ]
  depends_on = [kubernetes_namespace.namespace]
}
