module "google_networks" {
  source = "./modules/networks"

  project_id                     = var.project_id
  region                         = var.region
  subnet_name                    = var.subnet_name
  vpc_name                       = var.vpc_name
  cluster_master_ip_cidr_range   = var.cluster_master_ip
  cluster_pods_ip_cidr_range     = var.cluster_pods_ip
  cluster_services_ip_cidr_range = var.cluster_services_ip
}

module "google_kubernetes_cluster" {
  source = "./modules/kubernetes-cluster"

  cluster_name                           = var.cluster_name
  node_zones                             = ["${var.region}-a", "${var.region}-b", "${var.region}-c"]
  project_id                             = var.project_id
  region                                 = var.region
  service_account                        = var.service_account
  network_name                           = module.google_networks.vpc_name
  subnet_name                            = module.google_networks.subnet_name
  master_ipv4_cidr_block                 = var.master_ipv4_cidr
  pods_ipv4_cidr_block                   = var.pod_ipv4_cidr
  services_ipv4_cidr_block               = var.svc_ipv4_cidr
  master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
  spot_instance                          = true

  node_pools = {
    "nodepool" = {
      name           = "nodepool-${var.environment}"
      node_count     = var.node_count
      min_node_count = var.min_node_count
      max_node_count = var.max_node_count
      machine_type   = var.machine_type
      taints         = []
      labels = {
        "environment" = var.environment
      }
    }
  }
}