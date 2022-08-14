terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.31.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.31.0"
    }
  }
}

provider "google" {
  project = var.project
  ### more info can be found here: https://cloud.google.com/compute/docs/regions-zones#available 
  region = var.region
  zone   = var.region_zone
}

provider "google-beta" {
  project = var.project
  ### more info can be found here: https://cloud.google.com/compute/docs/regions-zones#available 
  region = var.region
  zone   = var.region_zone
}