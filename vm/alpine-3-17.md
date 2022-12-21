# Alpine 3.17 Template

To get an alpine 3.17 image template ready for other use, please 
run the following commands:

## 1. Make the initial system setup
```shell
setup-alpine
```

## 2. Prepare repositories

```shell
vi /etc/apk/repositories
# Uncomment community repository
```

## 3. Update & Upgrade the system 

```shell
apk update apk upgrade --available
sync
apk add curl qemu-guest-agent
reboot
```

## 4. Init scripts

Please copy `init-network` & `init-k3s` scripts to `usr/local/bin`.

NB: Make sure to chmod 755 them.

## 5. Change motd & other utilities

```shell
cat <<EOF > /etc/motd

Welcome to alexandre.mahdhaoui.com

System: alpine-3.17

You can setup the system with the commands:

        init-network-interactive
        init-k3s-cluster
        init-k3s-server-interactive
        init-k3s-agent-interactive

For more information, please visit: github.com/alexandremahdhaoui/infra-prox-ew1
EOF
```

```shell
echo -e 'set -o vi\nalias ll="ls -laF"' >> /etc/profile
```