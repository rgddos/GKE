variable "project" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" { 
  description = "GKE zone"
  type        = string
}

variable "gke_cluster_name" {
  description = "Name for the GKE cluster"
  type        = string
}

variable "gke_cluster_version" {
  description = "GKE cluster version"
  type        = string
}

variable "enable_private_nodes" {
  description = "Enable private nodes"
  type        = bool
  default     = true
}

variable "node_pool_count" {
  description = "Number of initial nodes in the node pool"
  type        = number
}

variable "node_locations" {
  description = "Location for the node pool"
  type        = list(string)
  default     = []
}

variable "node_pool_version" {
  description = "Node pool version"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "CIDR block for the master IP range"
  type        = string
  default     = ""
}
  

variable "cluster_ipv4_cidr_block" {
  description = "CIDR block for the cluster IP range"
  type        = string
  default     = ""
}

variable "services_ipv4_cidr_block" {
  description = "CIDR block for services IP range"
  type        = string
  default     = ""
}

variable "pod_ipv4_cidr_block" {
  description = "CIDR block for pod IP range"
  type        = string
  default     = ""
}

variable "pod_range" {
  description = "Name for the pod range"
  type        = string
}


variable "namespace_names" {
  description = "List of namespace names to create"
  type        = list(string) # Add more namespace names as needed
}


#ArgoCD
variable "create_argo-cd" {
  description = "Set to true to create the resource, set to false to ignore it"
  type        = bool  
  default = true  
}

#External Secrets
variable "create_external-secrets" {
  description = "Set to true to create the resource, set to false to ignore it"
  type        = bool    
}

#Redis
variable "create_redis" {
  description = "Set to true to create the resource, set to false to ignore it"
  type        = bool  
}


