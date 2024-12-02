provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  credentials = file("${path.module}/SA.json")
}

terraform {
  backend "gcs" {
    bucket = "tfstate-bucket"
    prefix = "terraform/state"
  }
}