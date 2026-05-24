resource "google_compute_network" "vpc" {

  name = "terraform-vpc"

  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "subnet" {

  name = "terraform-subnet"

  ip_cidr_range = "10.0.1.0/24"

  region = var.region

  network = google_compute_network.vpc.id

}

resource "google_compute_firewall" "allow" {

  name = "terraform-fw"

  network = google_compute_network.vpc.name

  allow {

    protocol = "tcp"

    ports = ["22", "80"]

  }

  allow {

    protocol = "icmp"

  }

  source_ranges = ["0.0.0.0/0"]

}

resource "google_compute_instance" "vm" {

  for_each = var.vms

  name = each.key

  machine_type = each.value

  zone = var.zone

  boot_disk {

    initialize_params {

      image = "debian-cloud/debian-12"

      size = 10

    }

  }

  network_interface {

    subnetwork = google_compute_subnetwork.subnet.id

    access_config {}

  }

  tags = ["terraform"]

}
