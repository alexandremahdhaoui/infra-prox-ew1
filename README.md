# infra-prox-ew1

# Repository structure

| Path   | Description                                         |
|--------|-----------------------------------------------------|
| `ct/`  | contains LXC related resources.                     |
| `vm/`  | contains Virtual Machine related resources.         |
| `tf/`  | contains terraform modules & related resources.     |
| `net/` | contains networking related resources.              |

# TODO

- [x] terraform module to launch a VM using cloud-init
- [x] terragrunt configuration to launch the `betterdns` VM.
  - Cannot be launch from local machine because the `10.128` private network is purposely unreachable from the internet.

# Getting started

This repository is dedicated to proxmox infrastructure in our `eu-west-1` datacenter (France). 
`infra`: infrastructure, `prox`: proxmox & `ew1`: datacenter in `eu-west-1`.

To get started with the repository I strongly suggest to checkout the `vm/` folder & checkout the different docs.

## Proxmox startup
```shell
cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian bullseye main contrib
deb http://ftp.debian.org/debian bullseye-updates main contrib

# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription

# security updates
deb http://security.debian.org/debian-security bullseye-security main contrib
EOF
apt update -y && apt upgrade -y
```

## Proxmox-cli

Please install [proxmox-cli](https://github.com/alexandremahdhaoui/proxmox-cli) for a better user experience.

[Proxmox-cli](https://github.com/alexandremahdhaoui/proxmox-cli) is a simple bash wrapper around the [Proxmox REST API](https://pve.proxmox.com/pve-docs/api-viewer/).It requires [curl](https://github.com/curl/curl) & [jq](https://github.com/stedolan/jq), so please make sure to have them installed.

## Curl the API

If you prefer to curl the API directly, here are a few steps to get started:

### Setup

```shell
export PM_API_URL=https://node0.mahdhaoui.com:8006/api2/json
export PM_USER_NAME=alexandre.mahdhaoui
export PM_USER_DOMAIN=pam
read -sp "Password? " PM_PASS
```

### Authenticate

```shell
pve.auth() {
  curl -k -s\
    -d "username=$PM_USER_NAME@$PM_USER_DOMAIN"\
    --data-urlencode "password=$PM_PASS" "$PM_API_URL/access/ticket"
}
export PM_AUTH_COOKIE="PVEAuthCookie=$(pve.auth | jq '.data.ticket' | sed 's/\"//g' )"
export PM_CSRF_HEADER="CSRFPreventionToken: $(pve.auth | jq '.data.CSRFPreventionToken')"
```

### Request the API

```shell
curl -k -b "$PM_AUTH_COOKIE" -H "$PM_CSRF_HEADER" "$PM_API_URL/nodes/node0/qemu" | jq
```