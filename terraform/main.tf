terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.proxmox_url
  pm_user         = var.proxmox_user
  pm_password     = var.proxmox_password
  pm_tls_insecure = true  # Set to true if you don't use TLS certificates
}

resource "proxmox_vm_qemu" "almalinux_vm" {
  count    = 1
  name     = "zabbixvm"
  target_node = "Debian-bookworm-latest-amd64-base"  # Proxmox node where the VM will be deployed

  # General VM Configuration
  cores    = 2
  memory   = 4096
  sockets  = 1
  cpu      = "host"

  # Storage and Disk Configuration
  disk {
    size            = "8G"
    type            = "scsi"
    storage         = "local"  # Name of your Proxmox storage pool
  }

  # Network Configuration
  network {
    model    = "virtio"
    bridge   = "vmbr0"  # Your network bridge in Proxmox
  }

  # Use AlmaLinux ISO or Template (you need to have this on Proxmox)
  clone = "Template"  # or use an ISO for installation
  clone_wait   = 30
  additional_wait = 20

  # Automatically start the VM after creation
  #onboot = true
}