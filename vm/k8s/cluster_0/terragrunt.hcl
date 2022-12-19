terraform {
  source = "../../../tf//k3s_cluster"

  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "validate",
      "refresh",
      "destroy",
    ]

    required_var_files = []
  }
}

inputs = {
  domain_name      = "alexandre.mahdhaoui.com"
  proxmox_base_url = "node0.mahdhaoui.com"
  proxmox_api_port = 8006

  // Control plane values
  control_plane_clone                    = "k8s-10-128-255-2"
  control_plane_cores                    = 1
  control_plane_desc                     = "control plane node for k3s cluster 0"
  control_plane_disk_size                = 8
  control_plane_disk_storage             = "local-lvm"
  control_plane_disk_type                = "scsi"
  control_plane_ip_config_addr           = "10.128.1.0"
  control_plane_ip_config_cidr_block     = 16
  control_plane_ip_config_cidr_sub_block = 24
  control_plane_ip_config_gateway        = "10.128.0.1"
  control_plane_memory                   = 4096
  control_plane_name                     = "k0cp"
  control_plane_nameserver               = "dns.alexandre.mahdhaoui.com"
  control_plane_nameserver_api_port      = 53
  control_plane_network_bridge           = "vmbr1"
  control_plane_network_nic_model        = "virtio"
  control_plane_node_count               = 3
  control_plane_os_type                  = "cloud-init"
  control_plane_pool                     = ""
  control_plane_remote_exec_commands     = []
  control_plane_sockets                  = 1
  control_plane_ssh_private_key          = ""
  control_plane_ssh_user                 = "root"
  control_plane_sshkeys                  = ""
  control_plane_target_node              = "node0"

  // Worker node values
  worker_clone                    = "k8s-10-128-255-2"
  worker_cores                    = 2
  worker_desc                     = "control plane node for k3s cluster 0"
  worker_disk_size                = 32
  worker_disk_storage             = "local-lvm"
  worker_disk_type                = "scsi"
  worker_ip_config_addr           = "10.128.2.0"
  worker_ip_config_cidr_block     = 16
  worker_ip_config_cidr_sub_block = 24
  worker_ip_config_gateway        = "10.128.0.1"
  worker_memory                   = 8192
  worker_name                     = "k0w"
  worker_nameserver               = "dns.alexandre.mahdhaoui.com"
  worker_nameserver_api_port      = 53
  worker_network_bridge           = "vmbr1"
  worker_network_nic_model        = "virtio"
  worker_node_count               = 3
  worker_os_type                  = "cloud-init"
  worker_pool                     = ""
  worker_remote_exec_commands     = []
  worker_sockets                  = 2
  worker_ssh_private_key          = ""
  worker_ssh_user                 = "root"
  worker_sshkeys                  = ""
  worker_target_node              = "node0"

}