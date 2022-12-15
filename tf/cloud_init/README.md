# Terraform Cloud Init

## Requirements

| Name                                                                | Version |
|---------------------------------------------------------------------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.11  |

## Providers

| Name                                                          | Version |
|---------------------------------------------------------------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.11  |

## Modules

No modules.

## Resources

| Name                                                                                                                | Type     |
|---------------------------------------------------------------------------------------------------------------------|----------|
| [proxmox_vm_qemu.cloud-init](https://registry.terraform.io/providers/Telmate/proxmox/2.9.11/docs/resources/vm_qemu) | resource |

## Inputs

| Name                                                                                                                            | Description                                                                                                             | Type           | Default | Required |
|---------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------|----------------|---------|:--------:|
| <a name="input_clone"></a> [clone](#input\_clone)                                                                               | Name of the template to clone, e.g. `betterdns`.                                                                        | `string`       | n/a     |   yes    |
| <a name="input_cores"></a> [cores](#input\_cores)                                                                               | Number of logical cores, e.g. 2.                                                                                        | `number`       | n/a     |   yes    |
| <a name="input_desc"></a> [desc](#input\_desc)                                                                                  | Description for the vm.                                                                                                 | `string`       | n/a     |   yes    |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size)                                                                 | Size of the disk, e.g. `8G`.                                                                                            | `string`       | n/a     |   yes    |
| <a name="input_disk_storage"></a> [disk\_storage](#input\_disk\_storage)                                                        | Name of the storage to be used, e.g. `local-lvm`.                                                                       | `string`       | n/a     |   yes    |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type)                                                                 | Type of the storage to be used, e.g. `scsi`.                                                                            | `string`       | n/a     |   yes    |
| <a name="input_eth0_cidr_block"></a> [eth0\_cidr\_block](#input\_eth0\_cidr\_block)                                             | More information can be found in the docs: https://pve.proxmox.com/wiki/Cloud-Init_Support#_cloud_init_specific_options | `string`       | n/a     |   yes    |
| <a name="input_eth0_gateway"></a> [eth0\_gateway](#input\_eth0\_gateway)                                                        | More information can be found in the docs: https://pve.proxmox.com/wiki/Cloud-Init_Support#_cloud_init_specific_options | `string`       | n/a     |   yes    |
| <a name="input_eth0_ip_addr"></a> [eth0\_ip\_addr](#input\_eth0\_ip\_addr)                                                      | More information can be found in the docs: https://pve.proxmox.com/wiki/Cloud-Init_Support#_cloud_init_specific_options | `string`       | n/a     |   yes    |
| <a name="input_memory"></a> [memory](#input\_memory)                                                                            | RAM size, e.g. `2048`.                                                                                                  | `number`       | n/a     |   yes    |
| <a name="input_name"></a> [name](#input\_name)                                                                                  | Name of the vm. Will also be used as the registered name in the DNS                                                     | `string`       | n/a     |   yes    |
| <a name="input_nameserver"></a> [nameserver](#input\_nameserver)                                                                | IP address of the nameserver, e.g. `10.128.0.2`.                                                                        | `string`       | n/a     |   yes    |
| <a name="input_nameserver_api_port"></a> [nameserver\_api\_port](#input\_nameserver\_api\_port)                                 | Port on which the REST API controlling the nameserver is listening, e.g. `8000`.                                        | `number`       | `8000`  |    no    |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge)                                                  | ID of the bridge interface, e.g. `vmbr0`.                                                                               | `string`       | n/a     |   yes    |
| <a name="input_network_nic_model"></a> [network\_nic\_model](#input\_network\_nic\_model)                                       | Network interface card, e.g. `virtio`.                                                                                  | `string`       | n/a     |   yes    |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type)                                                                       | Type of the operating system, e.g. `alpine`.                                                                            | `string`       | n/a     |   yes    |
| <a name="input_pm_api_port"></a> [pm\_api\_port](#input\_pm\_api\_port)                                                         | Port on which the Proxmox API is listening, `8006`.                                                                     | `number`       | n/a     |   yes    |
| <a name="input_pm_base_url"></a> [pm\_base\_url](#input\_pm\_base\_url)                                                         | Base URL to the Proxmox API, e.g. `mynode.mahdhaoui.com`.                                                               | `string`       | n/a     |   yes    |
| <a name="input_pool"></a> [pool](#input\_pool)                                                                                  | destination resource pool for the new VM.                                                                               | `string`       | n/a     |   yes    |
| <a name="input_remote_exec_commands"></a> [remote\_exec\_commands](#input\_remote\_exec\_commands)                              | List of commands to be executed after the default startup ones.                                                         | `list(string)` | n/a     |   yes    |
| <a name="input_remote_exec_startup_overwrite"></a> [remote\_exec\_startup\_overwrite](#input\_remote\_exec\_startup\_overwrite) | List of commands overwritting the default startup commands.                                                             | `list(string)` | `[]`    |    no    |
| <a name="input_sockets"></a> [sockets](#input\_sockets)                                                                         | Number of sockets, e.g. 1                                                                                               | `number`       | n/a     |   yes    |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key)                                             | Private key for the machine.                                                                                            | `string`       | n/a     |   yes    |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user)                                                                    | User on which cloud-init will set ssh up to, e.g. `root`.                                                               | `string`       | n/a     |   yes    |
| <a name="input_sshkeys"></a> [sshkeys](#input\_sshkeys)                                                                         | list of public ssh keys.                                                                                                | `string`       | n/a     |   yes    |
| <a name="input_target_node"></a> [target\_node](#input\_target\_node)                                                           | Ma,e of the target node, e.g. `mynode`.                                                                                 | `string`       | n/a     |   yes    |
| <a name="input_vmid"></a> [vmid](#input\_vmid)                                                                                  | ID of the vm to create.                                                                                                 | `string`       | n/a     |   yes    |

## Outputs

No outputs.