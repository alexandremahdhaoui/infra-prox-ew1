# Terraform K3S Cluster

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 2.9.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >= 2.9.11 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.cluster_init_node](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu) | resource |
| [proxmox_vm_qemu.control_plane_node](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu) | resource |
| [proxmox_vm_qemu.worker_node](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_plane_clone"></a> [control\_plane\_clone](#input\_control\_plane\_clone) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_cores"></a> [control\_plane\_cores](#input\_control\_plane\_cores) | n/a | `number` | n/a | yes |
| <a name="input_control_plane_desc"></a> [control\_plane\_desc](#input\_control\_plane\_desc) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_disk_size"></a> [control\_plane\_disk\_size](#input\_control\_plane\_disk\_size) | n/a | `number` | n/a | yes |
| <a name="input_control_plane_disk_storage"></a> [control\_plane\_disk\_storage](#input\_control\_plane\_disk\_storage) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_disk_type"></a> [control\_plane\_disk\_type](#input\_control\_plane\_disk\_type) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_ip_config_addr"></a> [control\_plane\_ip\_config\_addr](#input\_control\_plane\_ip\_config\_addr) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_ip_config_cidr_block"></a> [control\_plane\_ip\_config\_cidr\_block](#input\_control\_plane\_ip\_config\_cidr\_block) | n/a | `number` | n/a | yes |
| <a name="input_control_plane_ip_config_cidr_sub_block"></a> [control\_plane\_ip\_config\_cidr\_sub\_block](#input\_control\_plane\_ip\_config\_cidr\_sub\_block) | n/a | `number` | n/a | yes |
| <a name="input_control_plane_ip_config_gateway"></a> [control\_plane\_ip\_config\_gateway](#input\_control\_plane\_ip\_config\_gateway) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_memory"></a> [control\_plane\_memory](#input\_control\_plane\_memory) | n/a | `number` | n/a | yes |
| <a name="input_control_plane_name"></a> [control\_plane\_name](#input\_control\_plane\_name) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_nameserver"></a> [control\_plane\_nameserver](#input\_control\_plane\_nameserver) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_nameserver_api_port"></a> [control\_plane\_nameserver\_api\_port](#input\_control\_plane\_nameserver\_api\_port) | n/a | `number` | n/a | yes |
| <a name="input_control_plane_network_bridge"></a> [control\_plane\_network\_bridge](#input\_control\_plane\_network\_bridge) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_network_nic_model"></a> [control\_plane\_network\_nic\_model](#input\_control\_plane\_network\_nic\_model) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_node_count"></a> [control\_plane\_node\_count](#input\_control\_plane\_node\_count) | n/a | `number` | n/a | yes |
| <a name="input_control_plane_os_type"></a> [control\_plane\_os\_type](#input\_control\_plane\_os\_type) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_pool"></a> [control\_plane\_pool](#input\_control\_plane\_pool) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_remote_exec_commands"></a> [control\_plane\_remote\_exec\_commands](#input\_control\_plane\_remote\_exec\_commands) | n/a | `list(string)` | n/a | yes |
| <a name="input_control_plane_sockets"></a> [control\_plane\_sockets](#input\_control\_plane\_sockets) | n/a | `number` | n/a | yes |
| <a name="input_control_plane_ssh_password"></a> [control\_plane\_ssh\_password](#input\_control\_plane\_ssh\_password) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_ssh_private_key"></a> [control\_plane\_ssh\_private\_key](#input\_control\_plane\_ssh\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_ssh_user"></a> [control\_plane\_ssh\_user](#input\_control\_plane\_ssh\_user) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_sshkeys"></a> [control\_plane\_sshkeys](#input\_control\_plane\_sshkeys) | n/a | `string` | n/a | yes |
| <a name="input_control_plane_target_node"></a> [control\_plane\_target\_node](#input\_control\_plane\_target\_node) | n/a | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | n/a | yes |
| <a name="input_k3s_token"></a> [k3s\_token](#input\_k3s\_token) | value for K3S\_TOKEN | `string` | n/a | yes |
| <a name="input_proxmox_api_port"></a> [proxmox\_api\_port](#input\_proxmox\_api\_port) | n/a | `string` | n/a | yes |
| <a name="input_proxmox_base_url"></a> [proxmox\_base\_url](#input\_proxmox\_base\_url) | n/a | `string` | n/a | yes |
| <a name="input_worker_clone"></a> [worker\_clone](#input\_worker\_clone) | n/a | `string` | n/a | yes |
| <a name="input_worker_cores"></a> [worker\_cores](#input\_worker\_cores) | n/a | `number` | n/a | yes |
| <a name="input_worker_desc"></a> [worker\_desc](#input\_worker\_desc) | n/a | `string` | n/a | yes |
| <a name="input_worker_disk_size"></a> [worker\_disk\_size](#input\_worker\_disk\_size) | n/a | `number` | n/a | yes |
| <a name="input_worker_disk_storage"></a> [worker\_disk\_storage](#input\_worker\_disk\_storage) | n/a | `string` | n/a | yes |
| <a name="input_worker_disk_type"></a> [worker\_disk\_type](#input\_worker\_disk\_type) | n/a | `string` | n/a | yes |
| <a name="input_worker_ip_config_addr"></a> [worker\_ip\_config\_addr](#input\_worker\_ip\_config\_addr) | n/a | `string` | n/a | yes |
| <a name="input_worker_ip_config_cidr_block"></a> [worker\_ip\_config\_cidr\_block](#input\_worker\_ip\_config\_cidr\_block) | n/a | `number` | n/a | yes |
| <a name="input_worker_ip_config_cidr_sub_block"></a> [worker\_ip\_config\_cidr\_sub\_block](#input\_worker\_ip\_config\_cidr\_sub\_block) | n/a | `number` | n/a | yes |
| <a name="input_worker_ip_config_gateway"></a> [worker\_ip\_config\_gateway](#input\_worker\_ip\_config\_gateway) | n/a | `string` | n/a | yes |
| <a name="input_worker_memory"></a> [worker\_memory](#input\_worker\_memory) | n/a | `number` | n/a | yes |
| <a name="input_worker_name"></a> [worker\_name](#input\_worker\_name) | n/a | `string` | n/a | yes |
| <a name="input_worker_nameserver"></a> [worker\_nameserver](#input\_worker\_nameserver) | n/a | `string` | n/a | yes |
| <a name="input_worker_nameserver_api_port"></a> [worker\_nameserver\_api\_port](#input\_worker\_nameserver\_api\_port) | n/a | `number` | n/a | yes |
| <a name="input_worker_network_bridge"></a> [worker\_network\_bridge](#input\_worker\_network\_bridge) | n/a | `string` | n/a | yes |
| <a name="input_worker_network_nic_model"></a> [worker\_network\_nic\_model](#input\_worker\_network\_nic\_model) | n/a | `string` | n/a | yes |
| <a name="input_worker_node_count"></a> [worker\_node\_count](#input\_worker\_node\_count) | n/a | `number` | n/a | yes |
| <a name="input_worker_os_type"></a> [worker\_os\_type](#input\_worker\_os\_type) | n/a | `string` | n/a | yes |
| <a name="input_worker_pool"></a> [worker\_pool](#input\_worker\_pool) | n/a | `string` | n/a | yes |
| <a name="input_worker_remote_exec_commands"></a> [worker\_remote\_exec\_commands](#input\_worker\_remote\_exec\_commands) | n/a | `list(string)` | n/a | yes |
| <a name="input_worker_sockets"></a> [worker\_sockets](#input\_worker\_sockets) | n/a | `number` | n/a | yes |
| <a name="input_worker_ssh_password"></a> [worker\_ssh\_password](#input\_worker\_ssh\_password) | n/a | `string` | n/a | yes |
| <a name="input_worker_ssh_private_key"></a> [worker\_ssh\_private\_key](#input\_worker\_ssh\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_worker_ssh_user"></a> [worker\_ssh\_user](#input\_worker\_ssh\_user) | n/a | `string` | n/a | yes |
| <a name="input_worker_sshkeys"></a> [worker\_sshkeys](#input\_worker\_sshkeys) | n/a | `string` | n/a | yes |
| <a name="input_worker_target_node"></a> [worker\_target\_node](#input\_worker\_target\_node) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
