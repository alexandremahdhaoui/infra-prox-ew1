# Terraform

## Repository structure

This subfolder contains terraform modules & related resources.

## Interesting resources

| Name                                                                                    | Description                                                                                                                                                |
|-----------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs) | Proxmox terraform provider's documentation.                                                                                                                |
| [tf-prox-k3s](https://github.com/fvumbaca/terraform-proxmox-k3s )                       | Very interesting project that launches an entire k3s cluster using proxmox.                                                                                |
| [tf-prox-cloud-init](https://github.com/sdhibit/terraform-proxmox-cloud-init-vm)        | A bit trivial but can be inspired to create a wrapper module around the Proxmox provider.<br/><br/> The maintainer uses `tf-docs`, the repo is very clean. |

## Terraform Technical User

Please run:
```shell
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
pveum user add terraform-prov@pve --password <password>
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```