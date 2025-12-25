output "web_nic_id" {
  value = azurerm_network_interface.web-nic.id
}
output "app_nic_id" {
  value = azurerm_network_interface.app-nic.id
}
output "db_nic_id" {
  value = azurerm_network_interface.db-nic.id
}

output "web_vm_id" {
  value = azurerm_linux_virtual_machine.web-vm.id
}
output "app_vm_id" {
  value = azurerm_linux_virtual_machine.app-vm.id
}
# output "db_vm_id" {
#   value = azurerm_linux_virtual_machine.db-vm.id
# }

#PUBLIC IP
output "web_public_ip_address" {
  value = azurerm_public_ip.web-ip.ip_address
}
