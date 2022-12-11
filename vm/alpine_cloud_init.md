# Alpine

## Cloud-init ready alpine

### Start a new alpine VM

#### Startup the VM

```shell
setup-alpine
```

#### Enable community repo
```shell
vi /etc/apk/repositories
```
Uncomment the community repository

#### Install & setup cloud-init

```shell
apk update && apk upgrade && apk add cloud-init
setup-cloud-init
reboot
```

#### Inside pve

```shell
template_id=<<YOUR_TEMPLATE_VM_ID>>

qm set $template_id --ide2 local-lvm:cloudinit
qm set $template_id --boot order=scsi0
qm set $template_id --serial0 socket --vga serial0
qm template $template_id
```

#### Deploy a cloud-init template

```shell
template_id=<<YOUR_TEMPLATE_VM_ID>>
vm_id=<<ID_OF_YOUR_NEW_VM>>
vm_name=<<NAME_OF_YOUR_NEW_VM>>
qm clone $template_id $vm_id --name $vm_name
```