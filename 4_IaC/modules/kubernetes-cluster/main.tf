resource "google_container_cluster" "kubernetes_cluster" {
  name                     = var.cluster_name
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network_name
  subnetwork               = var.subnet_name

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.pods_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks_cidr_blocks
      content {
        cidr_block = cidr_blocks.value.cidr_block
      }
    }
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    master_global_access_config {
      enabled = true
    }
  }
}

resource "google_container_node_pool" "node_pool" {
  for_each = var.node_pools

  name              = "${google_container_cluster.kubernetes_cluster.name}-${each.value.name}"
  location          = google_container_cluster.kubernetes_cluster.location
  node_locations    = var.node_zones
  cluster           = google_container_cluster.kubernetes_cluster.name
  node_count        = each.value.node_count
  max_pods_per_node = 100

  autoscaling {
    max_node_count = each.value.max_node_count
    min_node_count = each.value.min_node_count
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]

    dynamic "taint" {
      for_each = each.value.taints
        content {
          effect = taint.value.effect
          key    = taint.value.key
          value  = taint.value.value
        }
    }

    labels = each.value.labels

    machine_type = each.value.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }
    preemptible = var.spot_instance
  }
}

