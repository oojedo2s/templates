resource "google_compute_network" "vpc_network" {
  name                    = "test-net"
  auto_create_subnetworks = false
}

# Create a subnetwork in the VPC Network that was created
resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "test-subnet"
  region        = module.global_vars.region
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = var.vpc_ip_addr
}

resource "google_compute_firewall" "allow-iap-traffic" {
  name        = "allow-iap-traffic"
  description = "Allows TCP connections from IAP to any instance on the network using port 22."
  direction   = "INGRESS"
  disabled    = false
  network     = google_compute_network.vpc_network.self_link
  source_ranges = [
    // Since we have private IP's for our GKE nodes we need to use Google IAP to access them
    // We need to allow this specific range to have access
    "35.235.240.0/20" // Cloud IAP's TCP netblock see https://cloud.google.com/iap/docs/using-tcp-forwarding
  ]

  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "deny-all-traffic" {
  name          = "deny-all-traffic"
  network       = google_compute_network.vpc_network.self_link
  source_ranges = ["0.0.0.0/0"]
  disabled      = false

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
  priority = 50000

  deny {
    protocol = "all"
  }
}

resource "google_compute_instance" "test" {
  for_each     = toset(var.vm_name)
  name         = each.key
  machine_type = var.machine_type["dev"]
  # For VM resizing after creation
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.image
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}


