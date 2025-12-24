resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    address_space       = var.address_space
    resource_group_name = var.resource_group_name
    location            =   var.location
}

#SUBNETS

resource "azurerm_subnet" "web_subnet" {
    name                 = var.web_subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vnet_name
    address_prefixes     = var.web_subnet_address_prefixes
    depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "app_subnet" {
    name                 = var.app_subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vnet_name
    address_prefixes     = var.app_subnet_address_prefixes
    depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "db_subnet" {
    name                 = var.db_subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vnet_name
    address_prefixes     = var.db_subnet_address_prefixes
    depends_on = [azurerm_virtual_network.vnet]
}

#NETWORK SECURITY GROUPS

resource "azurerm_network_security_group" "web_nsg" {
  name                = var.web_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "AllowSSH"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = var.app_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowFrontendToBackend"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "Allow5000"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "database_nsg" {
  name                = var.database_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowBackendToDatabase"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


