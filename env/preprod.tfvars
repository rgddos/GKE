#GKE
project            = 
region             = 
zone               = 
gke_cluster_name   = 
gke_cluster_version           = "1.25.14-gke.1474000"
node_pool_count    = 5
node_locations = 
node_pool_version = "1.24.17-gke.200"
network_name       = 
master_ipv4_cidr_block = "172.17.0.0/28"
pod_range            = "your-pod-range-name"
enable_private_nodes = true

#namespace
namespace_names     = ["argocd", "cert-manager", "redis","ingress-nginx","external-secrets"]

#Add-Ons
create_rabbitmq = true
create_redis = true
create_external-secrets = true
create_argo-cd = true
