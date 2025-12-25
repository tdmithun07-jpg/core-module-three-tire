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

#WEB IP
resource "azurerm_public_ip" "web-ip" {
  name                = "web-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  #sku = "Basic"
}

#NIC AND NSG ASSOCIATIONS for web
resource "azurerm_network_interface" "web-nic" {
  name                = var.web_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "public_configuration1"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web-ip.id
  }
  depends_on = [ azurerm_subnet.web_subnet ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_interface_security_group_association" "nic_group_web" {
  network_interface_id = azurerm_network_interface.web-nic.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

#NIC AND NSG ASSOCIATIONS for app
resource "azurerm_network_interface" "app-nic" {
  name                = var.app_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "app_configuration1"
    subnet_id                     = azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ azurerm_subnet.app_subnet ]
  lifecycle {
    create_before_destroy = true
  }
} 

resource "azurerm_network_interface_security_group_association" "nic_group_app" {
  network_interface_id = azurerm_network_interface.app-nic.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

#NIC AND NSG ASSOCIATIONS for db
resource "azurerm_network_interface" "db-nic" {
  name                = var.db_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "db_configuration1"
    subnet_id                     = azurerm_subnet.db_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ azurerm_subnet.db_subnet ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_interface_security_group_association" "nic_group_db" {
  network_interface_id = azurerm_network_interface.db-nic.id
  network_security_group_id = azurerm_network_security_group.database_nsg.id
}
