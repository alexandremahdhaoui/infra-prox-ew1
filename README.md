# infra-prox-ew1

## Getting started

This repository is dedicated to proxmox infrastructure in our `eu-west-1` datacenter (France).  

`infra-prox-ew1` stands for:
- `infra`: infrastructure
- `prox`: proxmox
- `ew1`: datacenter in `eu-west-1`

## Repository structure

| Path   | Description                                 |
|--------|---------------------------------------------|
| `ct/`  | contains LXC related resources.             |
| `vm/`  | contains Virtual Machine related resources. |
| `net/` | contains networking related resources.      |

# TODO

- [ ] Create `CoreDNS` VM template
- [ ] terraform module to launch a VM using cloud-init
- [ ] terraform module to launch `CoreDNS` VM.