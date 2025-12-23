output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

# output "address_space" {
#   value = azurerm_virtual_network.vnet.address_space
# }

#subnets outputs

output "web_subnet_prefix" {
  value = azurerm_subnet.web_subnet_address_prefixes_subnet.address_prefixes
}

output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}

output "app_subnet_prefix" {
  value = azurerm_subnet.app_subnet.address_prefixes
}
output "app_subnet_id" {
  value = azurerm_subnet.app_subnet.id
}

output "db_subnet_prefix" {
  value = azurerm_subnet.db_subnet.address_prefixes
}
output "db_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}