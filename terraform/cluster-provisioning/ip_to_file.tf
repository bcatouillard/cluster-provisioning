resource "local_file" "ansible_inventory" {
  content = templatefile("../../hosts/host.tmpl",
    {
      ansible_group_controlplanes = [for inst in google_compute_instance.default : inst.name if inst.labels["ansible-group"] == "controlplane"],
      hostname_controlplanes      = [for inst in google_compute_instance.default : "${google_compute_address.static_ip[inst.name].address} ansible_user=${split("@", google_service_account.default.email)[0]} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' ansible_ssh_private_key_file=${local_file.ssh_private_key_pem.filename}" if inst.labels["ansible-group"] == "controlplane"],
      ansible_group_nodes         = [for inst in google_compute_instance.default : inst.name if inst.labels["ansible-group"] == "node"],
      hostname_nodes              = [for inst in google_compute_instance.default : "${google_compute_address.static_ip[inst.name].address} ansible_user=${split("@", google_service_account.default.email)[0]} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' ansible_ssh_private_key_file=${local_file.ssh_private_key_pem.filename}" if inst.labels["ansible-group"] == "node"]
    }
  )
  filename = "../../hosts/inventory"
}
