resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.cluster_pods_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc.self_link
  project       = var.project_id
}
