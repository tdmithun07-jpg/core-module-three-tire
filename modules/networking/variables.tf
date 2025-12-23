variable "vnet_name" {
  description = "name of the virtual network"
  type        = string
  default = "dev-vnet"
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

#subnets
variable "web_subnet_name" {
  description = "name of the subnet"
  type        = string
  default = "web_subnet"
}
variable "web_subnet_address_prefixes" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default = [ "10.0.1.0/24" ]
}

variable "app_subnet_name" {
  description = "name of the subnet"
  type        = string
  default = "app_subnet"
}
variable "app_subnet_address_prefixes" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default = [ "10.0.2.0/24" ]
}

variable "db_subnet_name" {
  description = "name of the subnet"
  type        = string
  default = "db_subnet"
}
variable "db_subnet_address_prefixes" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default = [ "10.0.3.0/24" ]
}





