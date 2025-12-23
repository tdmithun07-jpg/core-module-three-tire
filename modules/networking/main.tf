resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    address_space       = var.address_space
    resource_group_name = var.resource_group_name
    location            =   var.location
}

#subnets

resource "azurerm_subnet" "web_subnet" {
    name                 = var.web_subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vnet_name
    address_prefixes     = var.web_subnet_address_prefixes
}

resource "azurerm_subnet" "app_subnet" {
    name                 = var.app_subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vnet_name
    address_prefixes     = var.app_subnet_address_prefixes
}

resource "azurerm_subnet" "db_subnet" {
    name                 = var.db_subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vnet_name
    address_prefixes     = var.db_subnet_address_prefixes
}

