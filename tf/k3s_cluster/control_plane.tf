locals {
  control_plane_clone       = var.control_plane_clone
  control_plane_desc        = var.control_plane_desc
  control_plane_name        = var.control_plane_name
  control_plane_node_count  = var.control_plane_node_count - 1
  control_plane_target_node = var.control_plane_target_node

  control_plane_nameserver          = var.control_plane_nameserver
  control_plane_nameserver_api_port = var.control_plane_nameserver_api_port
  control_plane_cores               = var.control_plane_cores
  control_plane_memory              = var.control_plane_memory
  control_plane_os_type             = var.control_plane_os_type
  control_plane_pool                = var.control_plane_pool
  control_plane_sockets             = var.control_plane_sockets
  control_plane_ssh_private_key     = var.control_plane_ssh_private_key
  control_plane_ssh_password        = var.control_plane_ssh_password
  control_plane_ssh_user            = var.control_plane_ssh_user
  control_plane_sshkeys             = var.control_plane_sshkeys
  control_plane_disk_size           = "${var.control_plane_disk_size}G"
  control_plane_disk_storage        = var.control_plane_disk_storage
  control_plane_disk_type           = var.control_plane_disk_type
  control_plane_network_bridge      = var.control_plane_network_bridge
  control_plane_network_nic_model   = var.control_plane_network_nic_model

  control_plane_ip_config_addr           = var.control_plane_ip_config_addr
  control_plane_ip_config_cidr_block     = var.control_plane_ip_config_cidr_block
  control_plane_ip_config_cidr_sub_block = var.control_plane_ip_config_cidr_sub_block
  control_plane_ip_config_gateway        = var.control_plane_ip_config_gateway
  control_plane_ip_cidr                  = format("%s/%s", local.control_plane_ip_config_addr, local.control_plane_ip_config_cidr_block)
  control_plane_ip_cidr_sub_block        = format("%s/%s", local.control_plane_ip_config_addr, local.control_plane_ip_config_cidr_sub_block)

  control_plane_remote_exec_commands = var.control_plane_remote_exec_commands

  k3s_token = var.k3s_token

  cluster_init_cmd = "curl -sfL https://get.k3s.io | K3S_TOKEN=${local.k3s_token} sh -s - server --cluster-init"
  server_cmd = format(
    "init-k3s-server %s %s",
    "https://${format(local.format_control_plane_name, local.control_plane_name, 0)}.${var.domain_name}/6443",
    local.k3s_token
  )

  format_control_plane_name      = "%s%s"
  format_control_plane_ip_config = "ip=%s/%s,gw=%s"
}

resource "proxmox_vm_qemu" "control_plane_node" {
  count = local.control_plane_node_count

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

  // server registration
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
          format(local.format_control_plane_ip_config, cidrhost(local.control_plane_ip_cidr_sub_block, count.index), local.control_plane_ip_config_cidr_block, local.control_plane_ip_config_gateway),
          cidrnetmask(local.control_plane_ip_cidr),
          local.control_plane_ip_config_gateway
        ),
        // Registers the node as {control plane,server}
        local.server_cmd,
      ],
      // Please note that `init-network` will reboot, further script may not work as expected.
      local.control_plane_remote_exec_commands
    )
  }
  depends_on = [proxmox_vm_qemu.cluster_init_node]
}