# infra-prox-ew1

## Repository structure

| Path                      | Description                                     |
|---------------------------|-------------------------------------------------|
| [ct/](./ct/README.md)     | contains LXC related resources.                 |
| [helm/](./helm/README.md) | contains guides for helm.                       |
| [net/](./net/README.md)   | contains networking related resources.          |
| [tf/](./tf/README.md)     | contains terraform modules & related resources. |
| [vm/](./vm/README.md)     | contains Virtual Machine related resources.     |

## Disclaimer

My homelab datacenter is a fun project, the goal is to have fun & enjoy the time spent on it. 
Thus, nothing in this repository should be taken seriously.

Especially my choice to use Alpine everywhere.

Alpine is my favorite distribution, I like muslc, busybox & apk. 
With Alpine, you're also not concerned by the famous `GNU/Linux` copypasta. 

This choice is a complete joke, therefor please don't take it seriously.

## Getting started

This repository is dedicated to proxmox infrastructure in our `eu-west-1` datacenter (France). 
`infra`: infrastructure, `prox`: proxmox & `ew1`: datacenter in `eu-west-1`.

To get started with the repository I strongly suggest to checkout the `vm/` folder & checkout the different docs.

### Proxmox startup
```shell
cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian bullseye main contrib
deb http://ftp.debian.org/debian bullseye-updates main contrib

## PVE pve-no-subscription repository provided by proxmox.com,
## NOT recommended for production use
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription

## security updates
deb http://security.debian.org/debian-security bullseye-security main contrib
EOF
apt update -y && apt upgrade -y && sync
```

### Proxmox-cli

Please install [proxmox-cli](https://github.com/alexandremahdhaoui/proxmox-cli) for a better user experience.

[Proxmox-cli](https://github.com/alexandremahdhaoui/proxmox-cli) is a simple bash wrapper around the [Proxmox REST API](https://pve.proxmox.com/pve-docs/api-viewer/).It requires [curl](https://github.com/curl/curl) & [jq](https://github.com/stedolan/jq), so please make sure to have them installed.

### Curl the API

If you prefer to curl the API directly, here are a few steps to get started:

#### Setup

```shell
export PM_API_URL=https://node0.mahdhaoui.com:8006/api2/json
export PM_USER_NAME=alexandre.mahdhaoui
export PM_USER_DOMAIN=pam
read -sp "Password? " PM_PASS
```

#### Authenticate

```shell
pve.auth() {
  curl -k -s\
    -d "username=$PM_USER_NAME@$PM_USER_DOMAIN"\
    --data-urlencode "password=$PM_PASS" "$PM_API_URL/access/ticket"
}
export PM_AUTH_COOKIE="PVEAuthCookie=$(pve.auth | jq '.data.ticket' | sed 's/\"//g' )"
export PM_CSRF_HEADER="CSRFPreventionToken: $(pve.auth | jq '.data.CSRFPreventionToken')"
```

#### Request the API

```shell
curl -k -b "$PM_AUTH_COOKIE" -H "$PM_CSRF_HEADER" "$PM_API_URL/nodes/node0/qemu" | jq
```