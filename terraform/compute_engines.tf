locals {
  instances-map = { for item in var.instances :
    "${item.name}" => {
      name  = item.name,
      label = item.label
    }
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.vpc.name
  target_tags   = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_address" "static_ip" {
  for_each = local.instances-map
  name     = "${each.value.name}-static-ip"
}

resource "google_compute_instance" "default" {
  for_each     = local.instances-map
  name         = each.value.name
  machine_type = "e2-medium"
  zone         = "${var.region}-a"
  tags         = ["allow-ssh"]
  labels = {
    ansible-group = each.value.label
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata = {
    ssh-keys = "${split("@", google_service_account.default.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name

    access_config {
      nat_ip = google_compute_address.static_ip[each.key].address
    }
  }

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
