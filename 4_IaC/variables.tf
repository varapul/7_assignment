variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where resources will be deployed"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "cluster_master_ip" {
  description = "CIDR range for Kubernetes master IPs"
  type        = string
}

variable "cluster_pods_ip" {
  description = "CIDR range for Kubernetes pods"
  type        = string
}

variable "cluster_services_ip" {
  description = "CIDR range for Kubernetes services"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "service_account" {
  description = "Service account for the Kubernetes cluster"
  type        = string
}

variable "master_ipv4_cidr" {
  description = "Master IPv4 CIDR block"
  type        = string
}

variable "pod_ipv4_cidr" {
  description = "Pods IPv4 CIDR block"
  type        = string
}

variable "svc_ipv4_cidr" {
  description = "Services IPv4 CIDR block"
  type        = string
}

variable "master_authorized_networks_cidr_blocks" {
  description = "List of CIDR blocks authorized to access the master"
  type        = list(object({
    cidr_block   = string
    display_name = string
  }))
}

variable "environment" {
  description = "Environment label for the resources"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the node pool"
  type        = string
}

variable "taints" {
  description = "List of taints to apply to nodes"
  type        = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = [] # Default is an empty list if no taints are specified
}

variable "node_count" {
  description = "The default number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "min_node_count" {
  description = "The minimum number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "The maximum number of nodes in the node pool"
  type        = number
  default     = 8
}