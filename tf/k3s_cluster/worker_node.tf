locals {
  worker_clone               = var.worker_clone
  worker_desc                = var.worker_desc
  worker_name                = var.worker_name
  worker_node_count          = var.worker_node_count
  worker_target_node         = var.worker_target_node
  worker_nameserver          = var.worker_nameserver
  worker_nameserver_api_port = var.worker_nameserver_api_port
  worker_cores               = var.worker_cores
  worker_memory              = var.worker_memory
  worker_os_type             = var.worker_os_type
  worker_pool                = var.worker_pool
  worker_sockets             = var.worker_sockets
  worker_ssh_private_key     = var.worker_ssh_private_key
  worker_ssh_password        = var.worker_ssh_password
  worker_ssh_user            = var.worker_ssh_user
  worker_sshkeys             = var.worker_sshkeys
  worker_disk_size           = "${var.worker_disk_size}G"
  worker_disk_storage        = var.worker_disk_storage
  worker_disk_type           = var.worker_disk_type
  worker_network_bridge      = var.worker_network_bridge
  worker_network_nic_model   = var.worker_network_nic_model

  worker_ip_config_addr           = var.worker_ip_config_addr
  worker_ip_config_cidr_block     = var.worker_ip_config_cidr_block
  worker_ip_config_cidr_sub_block = var.worker_ip_config_cidr_sub_block
  worker_ip_config_gateway        = var.worker_ip_config_gateway

  worker_ip_cidr                  = format("%s/%s", local.worker_ip_config_addr, local.worker_ip_config_cidr_block)
  worker_ip_cidr_sub_block        = format("%s/%s", local.worker_ip_config_addr, local.worker_ip_config_cidr_sub_block)

  worker_remote_exec_commands = var.worker_remote_exec_commands

  worker_cmd = format(
    "init-k3s-server %s %s",
    "https://${format(local.format_worker_name, local.control_plane_name, 0)}.${var.domain_name}/6443",
    local.k3s_token
  )

  format_worker_name      = "%s%s"
  format_worker_ip_config = "ip=%s/%s,gw=%s"
}

resource "proxmox_vm_qemu" "worker_node" {
  count = local.worker_node_count

  clone       = local.worker_clone
  desc        = local.worker_desc
  name        = format(local.format_worker_name, local.worker_name, count.index)
  target_node = local.worker_target_node
  vmid        = tonumber(replace(cidrhost(local.worker_ip_cidr_sub_block, count.index), ".", ""))

  ipconfig0  = format(
    local.format_worker_ip_config,
    cidrhost(local.worker_ip_cidr_sub_block, count.index),
    local.worker_ip_config_cidr_block,
    local.worker_ip_config_gateway
  )
  nameserver = local.worker_nameserver

  # The destination resource pool for the new VM
  cores   = local.worker_cores
  memory  = local.worker_memory
  os_type = local.worker_os_type
  pool    = local.worker_pool
  sockets = local.worker_sockets

  # ssh values
  ssh_private_key = local.worker_ssh_private_key
  ssh_user        = local.worker_ssh_user
  sshkeys         = local.worker_sshkeys

  disk {
    size    = local.worker_disk_size
    storage = local.worker_disk_storage
    type    = local.worker_disk_type
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  network {
    bridge = local.worker_network_bridge
    model  = local.worker_network_nic_model
  }

  // {worker,agent} registration
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      agent    = false
      user     = local.worker_ssh_user
      password = local.worker_ssh_password
      host     = cidrhost(local.worker_ip_cidr_sub_block, count.index)
    }

    inline = concat(
      [
        // Even if the setup is already done by cloud-init, `init-network` will register the node to the dns on boot.
        format(
          "init-network %s %s %s %s",
          format(local.format_worker_name, local.worker_name, count.index),
          format(local.format_worker_ip_config, cidrhost(local.worker_ip_cidr_sub_block, count.index), local.worker_ip_config_cidr_block, local.worker_ip_config_gateway),
          cidrnetmask(local.worker_ip_cidr),
          local.worker_ip_config_gateway
        ),
        // Registers the node as {control plane,server}
        local.worker_cmd,
      ],

      // Please note that `init-network` will reboot, further script may not work as expected.
      local.worker_remote_exec_commands
    )
  }
  depends_on = [proxmox_vm_qemu.control_plane_node]
}