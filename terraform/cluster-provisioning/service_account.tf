resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${abspath("${path.root}/../..")}/.ssh/google_compute_engine"
  file_permission = "0600"
}


resource "google_service_account" "default" {
  account_id   = "compute-engine-svc"
  display_name = "Custom SA for VM Instance"
}
