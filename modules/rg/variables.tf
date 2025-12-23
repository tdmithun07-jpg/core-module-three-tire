variable "resource_group_name" {
  description = "name of rg"
  type = string
  default = "dev-resource-group"
}

variable "location" {
  description = "region of the rg"
  type = string
  default = "eastus"
}