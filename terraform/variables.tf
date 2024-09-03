variable "resource_group_name" {
  default = "zabbix-rg"
}

variable "location" {
  default = "Germany North"
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "zabbixadmin"
}

variable "admin_password" {
  description = "The admin password for the VM and Ansible"
  type        = string
  sensitive   = true
}