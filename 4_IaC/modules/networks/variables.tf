variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where the VPC and subnet will be created"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "cluster_master_ip_cidr_range" {
  description = "CIDR block for Kubernetes master nodes"
  type        = string
}

variable "cluster_pods_ip_cidr_range" {
  description = "CIDR block for Kubernetes pods"
  type        = string
}

variable "cluster_services_ip_cidr_range" {
  description = "CIDR block for Kubernetes services"
  type        = string
}