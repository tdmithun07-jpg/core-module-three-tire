variable "location" {
  description = "location of the resource"
  type = string
  #default = "eastus"
}
variable "resource_group_name" {
  description = "name of resource group"
  type = string
#   default = "dev-rg"
}
variable "web_ip_name" {
  description = "name of the public ip"
  type = string
  default = "web-public-ip"
}

#NIC Variables

variable "web_network_interface_name" {
  description = "name of nic"
  type = string
#   default = "public_nic"
}
variable "web_subnet_id" {
  description = "ID of the subnet"
  type = string
}

variable "app_network_interface_name" {
  description = "name of nic"
  type = string
}
variable "app_subnet_id" {
  description = "ID of the subnet"
  type = string
}
variable "db_network_interface_name" {
  description = "name of nic"
  type = string
}
variable "db_subnet_id" {
  description = "ID of the subnet"
  type = string
}

#VM Variables

variable "web_virtual_machine_name" {
  description = "name of the virtual machine"
  type = string
  default = "web-vm"
}
variable "app_virtual_machine_name" {
  description = "name of the virtual machine"
  type = string
  default = "app-vm"
}
variable "db_virtual_machine_name" {
  description = "name of the virtual machine"
  type = string
  default = "db-vm"
}


