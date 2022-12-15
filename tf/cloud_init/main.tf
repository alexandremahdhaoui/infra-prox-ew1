locals {
  ip_config_0 = "ip=${var.eth0_ip_addr}/${var.eth0_cidr_block},gw=${var.eth0_gateway}"
  remote_exec_startup_default = [
    "curl -XPOST ${var.nameserver}:${var.nameserver_api_port}/a --data '{\"name\": \"${var.name}\", \"class\": \"IN\", \"record_type\": \"A\", \"value\": \"${var.eth0_ip_addr}\"}'"
  ]
  remote_exec_startup  = var.remote_exec_startup_overwrite != null ? var.remote_exec_startup_overwrite : local.remote_exec_startup_default
  remote_exec_commands = concat(local.remote_exec_startup, var.remote_exec_commands)
}

resource "proxmox_vm_qemu" "cloud-init" {
  clone       = var.clone
  desc        = var.desc
  name        = var.name
  target_node = var.target_node
  vmid        = var.vmid

  ipconfig0  = local.ip_config_0
  nameserver = var.nameserver

  # The destination resource pool for the new VM
  cores   = var.cores
  memory  = var.memory
  os_type = var.os_type
  pool    = var.pool
  sockets = var.sockets

  # ssh values
  ssh_private_key = var.ssh_private_key
  ssh_user        = var.ssh_user
  sshkeys         = var.sshkeys


  disk {
    size    = var.disk_size
    storage = var.disk_storage
    type    = var.disk_type
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  network {
    bridge = var.network_bridge
    model  = var.network_nic_model
  }

  provisioner "remote-exec" {
    inline = local.remote_exec_commands
  }
}