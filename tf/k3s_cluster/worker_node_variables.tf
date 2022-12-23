variable "worker_clone" {
  description = ""
  type        = string
}
variable "worker_cores" {
  description = ""
  type        = number
}
variable "worker_desc" {
  description = ""
  type        = string
}
variable "worker_disk_size" {
  description = ""
  type        = number
}
variable "worker_disk_storage" {
  description = ""
  type        = string
}
variable "worker_disk_type" {
  description = ""
  type        = string
}
variable "worker_ip_config_addr" {
  description = ""
  type        = string
}
variable "worker_ip_config_cidr_block" {
  description = ""
  type        = number
}
variable "worker_ip_config_cidr_sub_block" {
  description = ""
  type        = number
}
variable "worker_ip_config_gateway" {
  description = ""
  type        = string
}
variable "worker_memory" {
  description = ""
  type        = number
}
variable "worker_name" {
  description = ""
  type        = string
}
variable "worker_nameserver" {
  description = ""
  type        = string
}
variable "worker_nameserver_api_port" {
  description = ""
  type        = number
}
variable "worker_network_bridge" {
  description = ""
  type        = string
}
variable "worker_network_nic_model" {
  description = ""
  type        = string
}
variable "worker_node_count" {
  description = ""
  type        = number
}
variable "worker_os_type" {
  description = ""
  type        = string
}
variable "worker_pool" {
  description = ""
  type        = string
}
variable "worker_remote_exec_commands" {
  description = ""
  type        = list(string)
}
variable "worker_sockets" {
  description = ""
  type        = number
}
variable "worker_ssh_private_key" {
  description = ""
  type        = string
}
variable "worker_ssh_password" {
  description = ""
  type        = string
}
variable "worker_ssh_user" {
  description = ""
  type        = string
}
variable "worker_sshkeys" {
  description = ""
  type        = string
}
variable "worker_target_node" {
  description = ""
  type        = string
}