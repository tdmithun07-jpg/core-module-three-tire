variable "vnet_name" {
  description = "name of the virtual network"
  type        = string
  default = "dev-virtual-network"
}
variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default = ["10.0.0.0/16"]
}
variable "resource_group_name" {
  description = "name of rg"
  type = string
}
variable "location" {
  description = "region of the rg"
  type = string
}

#Subnet Variables
variable "web_subnet_name" {
  description = "name of the subnet"
  type        = string
  default = "web-subnet"
}
variable "web_subnet_address_prefixes" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default = [ "10.0.1.0/24" ]
}

variable "app_subnet_name" {
  description = "name of the subnet"
  type        = string
  default = "app-subnet"
}
variable "app_subnet_address_prefixes" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default = [ "10.0.2.0/24" ]
}

variable "db_subnet_name" {
  description = "name of the subnet"
  type        = string
  default = "db-subnet"
}
variable "db_subnet_address_prefixes" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default = [ "10.0.3.0/24" ]
}

#NSG Variables
variable "web_nsg_name" {
  description = "name of the network security group"
  type        = string
  default = "web-nsg"
}

variable "app_nsg_name" {
  description = "name of the network security group"
  type        = string
  default = "app-nsg"
}

variable "database_nsg_name" {
  description = "name of the network security group"
  type        = string
  default = "database-nsg"
}

# #NIC Variables
# variable "web_nic_name" {
#   description = "name of nic"
#   type = string
#   default = "web-nic"
# }
# variable "app_nic_name" {
#   description = "name of nic"
#   type = string
#   default = "app-nic"
# }
# variable "db_nic_name" {
#   description = "name of nic"
#   type = string
#   default = "db-nic"
# }




