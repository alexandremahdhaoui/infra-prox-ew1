variable "control_plane_clone" {
  description = ""
  type        = string
}
variable "control_plane_cores" {
  description = ""
  type        = number
}
variable "control_plane_desc" {
  description = ""
  type        = string
}
variable "control_plane_disk_size" {
  description = ""
  type        = number
}
variable "control_plane_disk_storage" {
  description = ""
  type        = string
}
variable "control_plane_disk_type" {
  description = ""
  type        = string
}
variable "control_plane_ip_config_addr" {
  description = ""
  type        = string
}
variable "control_plane_ip_config_cidr_block" {
  description = ""
  type        = number
}
variable "control_plane_ip_config_cidr_sub_block" {
  description = ""
  type        = number
}
variable "control_plane_ip_config_gateway" {
  description = ""
  type        = string
}
variable "control_plane_memory" {
  description = ""
  type        = number
}
variable "control_plane_name" {
  description = ""
  type        = string
}
variable "control_plane_nameserver" {
  description = ""
  type        = string
}
variable "control_plane_nameserver_api_port" {
  description = ""
  type        = number
}
variable "control_plane_network_bridge" {
  description = ""
  type        = string
}
variable "control_plane_network_nic_model" {
  description = ""
  type        = string
}
variable "control_plane_node_count" {
  description = ""
  type        = number
}
variable "control_plane_os_type" {
  description = ""
  type        = string
}
variable "control_plane_pool" {
  description = ""
  type        = string
}
variable "control_plane_remote_exec_commands" {
  description = ""
  type        = list(string)
}
variable "control_plane_sockets" {
  description = ""
  type        = number
}
variable "control_plane_ssh_private_key" {
  description = ""
  type        = string
}
variable "control_plane_ssh_password" {
  description = ""
  type        = string
}
variable "control_plane_ssh_user" {
  description = ""
  type        = string
}
variable "control_plane_sshkeys" {
  description = ""
  type        = string
}
variable "control_plane_target_node" {
  description = ""
  type        = string
}