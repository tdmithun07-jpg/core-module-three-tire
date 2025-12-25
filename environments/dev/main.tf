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

  web_nsg_id          = module.network.web_nsg_id
  app_nsg_id          = module.network.app_nsg_id
  db_nsg_id           = module.network.db_nsg_id

  web_subnet_id       = module.network.web_subnet_id
  app_subnet_id       = module.network.app_subnet_id
  db_subnet_id        = module.network.db_subnet_id

  web_public_ip_address_id = module.network.web_public_ip_id
  app_public_ip_address_id = module.network.app_public_ip_id
  db_public_ip_address_id  = module.network.db_public_ip_id

}

