resource "proxmox_vm_qemu" "preprovision-test" {
  name        = "tftest1.xyz.com"
  desc        = "tf description"
  target_node = "proxmox1-xx"

  clone = "terraform-ubuntu1404-template"

  # The destination resource pool for the new VM
  pool = "pool0"

  cores    = 3
  sockets  = 1
  # Same CPU as the Physical host, possible to add cpu flags
  # Ex: "host,flags=+md-clear;+pcid;+spec-ctrl;+ssbd;+pdpe1gb"
  cpu      = "host"
  numa     = false
  memory   = 2560
  scsihw   = "lsi"
  # Boot from hard disk (c), CD-ROM (d), network (n)
  boot     = "cdn"
  # It's possible to add this type of material and use it directly
  # Possible values are: network,disk,cpu,memory,usb
  hotplug  = "network,disk,usb"
  # Default boot disk
  bootdisk = "virtio0"
  # HA, you need to use a shared disk for this feature (ex: rbd)
  hastate  = ""

  #Display
  vga {
    type   = "std"
    #Between 4 and 512, ignored if type is defined to serial
    memory = 4
  }

  network {
    id    = 0
    model = "virtio"
  }
  network {
    id     = 1
    model  = "virtio"
    bridge = "vmbr1"
  }
  disk {
    id           = 0
    type         = "virtio"
    storage      = "local-lvm"
    storage_type = "lvm"
    size         = "4G"
    backup       = true
  }
  # Serial interface of type socket is used by xterm.js
  # You will need to configure your guest system before being able to use it
  serial {
    id   = 0
    type = "socket"
  }
  preprovision    = true
  ssh_forward_ip  = "10.0.0.1"
  ssh_user        = "terraform"
  ssh_private_key = <<EOF
-----BEGIN RSA PRIVATE KEY-----
private ssh key terraform
-----END RSA PRIVATE KEY-----
EOF

  os_type           = "ubuntu"
  os_network_config = <<EOF
auto eth0
iface eth0 inet dhcp
EOF

  connection {
    type        = "ssh"
    user        = self.ssh_user
    private_key = self.ssh_private_key
    host        = self.ssh_host
    port        = self.ssh_port
  }

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}