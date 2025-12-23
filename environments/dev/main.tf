module "resource_group" {
  source = "github.com/tdmithun07-jpg/core-module-three-tire/modules/rg"
}

module "network" {
  source              = "github.com/tdmithun07-jpg/core-module-three-tire/modules/networking"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
}

module "compute" {
  source              = "github.com/tdmithun07-jpg/core-module-three-tire/modules/compute"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  web_subnet_id = module.network.web_subnet_id
  app_subnet_id = module.network.app_subnet_id
  db_subnet_id  = module.network.db_subnet_id

  web_network_interface_name = "web-nic"
  app_network_interface_name = "app-nic"

  web_network_interface_ids = [azurerm_network_interface.web-nic.id]
  app_network_interface_ids = [azurerm_network_interface.app-nic.id]
  #db_network_interface_ids  = [azurerm_network_interface.db-nic.id]

  web_public_ip_address_id = module.compute.web_public_ip_address
  #app_public_ip_address_id = null
  #db_public_ip_address_id  = module.compute.db_public_ip_address

  web_nsg_id = module.network.web_nsg_id
  app_nsg_id = module.network.app_nsg_id
}

