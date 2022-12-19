terraform {
  source = "../../tf//cloud_init"

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

#include {
#  path = find_in_parent_folders()
#}


inputs = {
  cores                         = "1"
  clone                         = "betterdns"
  desc                          = "Nameserver for 10.128.0.0/16 network."
  disk_size                     = "8G"
  disk_type                     = "scsi"
  disk_storage                  = "VM1"
  eth0_ip_addr                  = "10.128.10.2"
  eth0_cidr_block               = "16"
  eth0_gateway                  = "10.128.0.1"
  memory                        = "1024"
  name                          = "dns-128-test"
  nameserver                    = "10.128.0.1"
  network_bridge                = "vmbr1"
  network_nic_model             = "virtio"
  os_type                       = "alpine"
  pm_base_url                   = "node0.mahdhaoui.com"
  pm_api_port                   = "8006"
  pool                          = ""
  remote_exec_commands          = []
  remote_exec_startup_overwrite = [
    "cd $HOME/betterdns_bin && betterdns &"
  ]
  sockets                       = "1"
  ssh_user                      = "root"
  ssh_private_key               = ""
  sshkeys                       = ""
  target_node                   = "node0"
  vmid                          = "128010002"
}