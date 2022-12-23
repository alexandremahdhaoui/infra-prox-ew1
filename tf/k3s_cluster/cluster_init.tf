resource "proxmox_vm_qemu" "cluster_init_node" {
  count = 1

  clone       = local.control_plane_clone
  desc        = local.control_plane_desc
  name        = format(local.format_control_plane_name, local.control_plane_name, count.index)
  target_node = local.control_plane_target_node
  vmid        = tonumber(replace(cidrhost(local.control_plane_ip_cidr_sub_block, count.index), ".", ""))

  ipconfig0 = format(
    local.format_control_plane_ip_config,
    cidrhost(local.control_plane_ip_cidr_sub_block, count.index),
    local.control_plane_ip_config_cidr_block,
    local.control_plane_ip_config_gateway
  )
  nameserver = local.control_plane_nameserver

  # The destination resource pool for the new VM
  cores   = local.control_plane_cores
  memory  = local.control_plane_memory
  os_type = local.control_plane_os_type
  pool    = local.control_plane_pool
  sockets = local.control_plane_sockets

  # ssh values
  ssh_private_key = local.control_plane_ssh_private_key
  ssh_user        = local.control_plane_ssh_user
  sshkeys         = local.control_plane_sshkeys

  disk {
    size    = local.control_plane_disk_size
    storage = local.control_plane_disk_storage
    type    = local.control_plane_disk_type
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  network {
    bridge = local.control_plane_network_bridge
    model  = local.control_plane_network_nic_model
  }

  // cluster-init
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      agent    = false
      user     = local.control_plane_ssh_user
      password = local.control_plane_ssh_password
      host     = cidrhost(local.control_plane_ip_cidr_sub_block, count.index)
    }

    inline = concat(
      [
        // Even if the setup is already done by cloud-init, `init-network` will register the node to the dns on boot.
        format(
          "init-network %s %s %s %s",
          format(local.format_control_plane_name, local.control_plane_name, count.index),
          format(local.format_control_plane_ip_config, cidrhost(local.control_plane_ip_cidr_sub_block, count.index), local.control_plane_ip_config_cidr_sub_block, local.control_plane_ip_config_gateway),
          cidrnetmask(local.control_plane_ip_cidr),
          local.control_plane_ip_config_gateway
        ),
        // Initialize the cluster
        local.cluster_init_cmd,

        // sleep before running `init-network`.
        "sleep 30",
      ],
      // Please note that `init-network` will reboot, further script may not work as expected.
      local.control_plane_remote_exec_commands
    )
  }
}