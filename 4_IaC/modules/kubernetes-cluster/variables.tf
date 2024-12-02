variable "project_id" {
  type        = string
  description = "Project ID "
}

variable "region" {
  type        = string
  description = "Region"
}

variable "node_zones" {
  type        = list(string)
  description = "The zones where worker nodes are located"
}

variable "network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "service_account" {
  type = string
}

variable "pods_ipv4_cidr_block" {
  type = string
}

variable "services_ipv4_cidr_block" {
  type = string
}

variable "master_ipv4_cidr_block" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(map(string))
}

variable "add_labels" {
  type    = bool
  default = false
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "node_pools" {
  description = "A map of objects defining the Kubernetes node pools to create."
  type        = map(object({
    name           = string
    node_count     = number
    max_node_count = number
    min_node_count = number
    machine_type   = string
    taints         = list(object({
      key    = string
      value  = string
      effect = string
    }))
    labels         = map(string)
  }))
}

variable "spot_instance" {
  description = "Use spot instances"
  type        = bool
  default     = false
}