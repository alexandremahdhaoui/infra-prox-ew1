# infra-prox-ew1

# Repository structure

| Path   | Description                                         |
|--------|-----------------------------------------------------|
| `ct/`  | contains LXC related resources.                     |
| `vm/`  | contains Virtual Machine related resources.         |
| `tf/`  | contains terraform modules & related resources.     |
| `net/` | contains networking related resources.              |

# TODO

- [ ] Create `CoreDNS` VM template
- [ ] terraform module to launch a VM using cloud-init
- [ ] terraform module to launch `CoreDNS` VM.

- Once VM are started: do installation in /vm/alpine_coredns.md
- Create `nonroot` user
- Give it access to coredns
- Cleanup duplicated binaries
- Cleanup history
- Lookup how to make a non-root user secure in alpine.
- Lookup how to set up TLS certificates (for DoT, DoH, and gRPC).
- Template the VM

# Getting started

This repository is dedicated to proxmox infrastructure in our `eu-west-1` datacenter (France).  

`infra-prox-ew1` stands for:
- `infra`: infrastructure
- `prox`: proxmox
- `ew1`: datacenter in `eu-west-1`

