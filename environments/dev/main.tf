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

  web_network_interface_ids = [module.network.web_nic_id]
  app_network_interface_ids = [module.network.app_nic_id]
  db_network_interface_ids = [module.network.db_nic_id]

  web_nsg_id = module.network.web_nsg_id
  app_nsg_id = module.network.app_nsg_id
  db_nsg_id = module.network.db_nsg_id
}
#testcomment
