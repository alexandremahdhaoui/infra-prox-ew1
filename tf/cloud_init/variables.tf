variable "cores" {
  description = "Number of logical cores, e.g. 2."
  type        = number
}

variable "clone" {
  description = "Name of the template to clone, e.g. `betterdns`."
  type        = string
}

variable "desc" {
  description = "Description for the vm."
  type        = string
}

variable "disk_size" {
  description = "Size of the disk, e.g. `8G`."
  type        = string
  validation {
    condition     = length(regexall("^[0-9]+G$", var.disk_size)) > 0
    error_message = "Disk size must comply to the regex: ^[0-9]+G$"
  }
}

variable "disk_storage" {
  description = "Name of the storage to be used, e.g. `local-lvm`."
  type        = string
}

variable "disk_type" {
  description = "Type of the storage to be used, e.g. `scsi`."
  type        = string
}

variable "eth0_ip_addr" {
  description = "More information can be found in the docs: https://pve.proxmox.com/wiki/Cloud-Init_Support#_cloud_init_specific_options"
  type        = string
}

variable "eth0_cidr_block" {
  description = "More information can be found in the docs: https://pve.proxmox.com/wiki/Cloud-Init_Support#_cloud_init_specific_options"
  type        = string
}

variable "eth0_gateway" {
  description = "More information can be found in the docs: https://pve.proxmox.com/wiki/Cloud-Init_Support#_cloud_init_specific_options"
  type        = string
}

variable "memory" {
  description = "RAM size, e.g. `2048`."
  type        = number
  validation {
    condition     = var.memory > 16
    error_message = "`memory` should be superior to 16."
  }
}

variable "name" {
  description = "Name of the vm. Will also be used as the registered name in the DNS"
  type        = string
  validation {
    condition     = length(var.name) < 63 && length(regexall("^([a-z0-9-]+)$", var.name)) > 0
    error_message = "The `name` of the VM & its length should be inferior to 63"
  }
}

variable "nameserver" {
  description = "IP address of the nameserver, e.g. `10.128.0.2`."
  type        = string
}

variable "nameserver_api_port" {
  description = "Port on which the REST API controlling the nameserver is listening, e.g. `8000`."
  type        = number
  default     = 8000
}

variable "network_bridge" {
  description = "ID of the bridge interface, e.g. `vmbr0`."
  type        = string
}

variable "network_nic_model" {
  description = "Network interface card, e.g. `virtio`."
  type        = string
}

variable "os_type" {
  description = "Type of the operating system, e.g. `alpine`."
  type        = string
}

variable "pm_base_url" {
  description = "Base URL to the Proxmox API, e.g. `mynode.mahdhaoui.com`."
  type        = string
}

variable "pm_api_port" {
  description = "Port on which the Proxmox API is listening, `8006`."
  type        = number
}

variable "pool" {
  description = "destination resource pool for the new VM."
  type        = string
}

variable "remote_exec_startup_overwrite" {
  description = "List of commands overwritting the default startup commands."
  type        = list(string)
  default     = []
}

variable "remote_exec_commands" {
  description = "List of commands to be executed after the default startup ones."
  type        = list(string)
}

variable "sockets" {
  description = "Number of sockets, e.g. 1"
  type        = number
}

variable "ssh_user" {
  description = "User on which cloud-init will set ssh up to, e.g. `root`."
  type        = string
}

variable "ssh_private_key" {
  description = "Private key for the machine."
  type        = string
}

variable "sshkeys" {
  description = "list of public ssh keys."
  type        = string
}

variable "target_node" {
  description = "Ma,e of the target node, e.g. `mynode`."
  type        = string
}

variable "vmid" {
  description = "ID of the vm to create."
  type        = string
}