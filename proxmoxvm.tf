provider "proxmox" {
  pm_api_url      = "https://lf10.taiclab.de:8006/api2/json"
  pm_user         = "root"
  pm_password     = "ireL5kUYMkBMcF"
  pm_tls_insecure = true  # Set to true if you don't use TLS certificates
}

resource "proxmox_vm_qemu" "almalinux_vm" {
  count    = 1
  name     = "zabbixvm"
  target_node = "LF10-Proxmox"  # Proxmox node where the VM will be deployed

  # General VM Configuration
  cores    = 2
  memory   = 4096
  sockets  = 1
  cpu      = "host"

  # Storage and Disk Configuration
  disk {
    size            = "8G"
    type            = "scsi"
    storage         = "local-lvm"  # Name of your Proxmox storage pool
    storage_type    = "lvm"
  }

  # Network Configuration
  network {
    model    = "virtio"
    bridge   = "vmbr0"  # Your network bridge in Proxmox
  }

  # Use AlmaLinux ISO or Template (you need to have this on Proxmox)
  clone = "Template"  # or use an ISO for installation
  
  # Cloud-init Configuration
  ipconfig0 = "ip=dhcp"  # Use DHCP for network configuration
  ciuser    = "zabbix"  # Default user for AlmaLinux cloud images
  cipassword = "password"  # Password for the user
  
  sshkeys = <<EOF
ssh-rsa AAAAB...your-ssh-public-key... sabaton@your-machine
EOF

  # Automatically start the VM after creation
  onboot = true
}

