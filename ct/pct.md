# Proxmox Containers

## Create a lxc container from dockerhub

### Install requirements

| Required tools |
|----------------|
| `git`          |
| `vim`          |
| `make`         |
| `skopeo`       |
| `umoci`        |
| `go-md2man`    |
| `jq`           |
| `binutils`     |

#### First let's go in /tmp folder
```shell
cd /tmp
```
#### Update & upgrade your system
```shell
apt-get update -y
apt-get upgrade -y
```

#### Install go latest version
```shell
wget "https://go.dev/dl/$(curl 'https://go.dev/VERSION?m=text').linux-amd64.tar.gz" \
  && rm -rf /usr/local/go \
  && tar -C /usr/local -xzf go*.linux-amd64.tar.gz
mkdir -p "$HOME/go/{bin,src,pkg}"
echo -e 'export PATH=$PATH:/usr/local/go/bin\nexport GOPATH="$HOME/go"\nexport GOBIN="$GOPATH/bin"' >> "$HOME/.bashrc"
. "$HOME/.bashrc"
```

#### Install tools
```shell
apt-get -y install git make skopeo go-md2man vim jq binutils
```

#### Installing umoci

```shell
git clone https://github.com/opencontainers/umoci &&\
  cd umoci &&\
  git checkout v0.4.7 &&\
  make install 
```

#### You can now create LXC containers from docker

```shell
lxc-create test -t oci -- --url docker://coredns/coredns:latest
lxc-ls
lxc-destroy test
```

### Creating CoreDNS LX container

```shell
lxc-create coredns -t oci -- --url docker://coredns/coredns:latest
tar -cvzf /var/lib/vz/template/cache/coredns.tar.gz /var/lib/lxc/coredns/rootfs/*
```

### As a function

```shell
lxc.import() {
  name="$1"
  repo="$2"
  INPUT_DIR="/var/lib/lxc/$name/rootfs/*"
  OUTPUT_DIR="/var/lib/vz/template/cache/$name.tar.gz"
 
  lxc-create "$name" -t oci -- --url docker://"$repo"
  tar -cvzf "$INPUT_DIR" "$OUTPUT_DIR" 
}
```