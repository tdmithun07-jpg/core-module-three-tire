data "azurerm_key_vault" "kv" {
  name                = "dev-keyvault-1612"
  resource_group_name = "keyvault-rg"
}

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "vm1-ssh-public"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# data "azurerm_key_vault_secret" "ssh_private_key" {
#   name         = "vm1-ssh-private"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

#WEB IP
resource "azurerm_public_ip" "web-ip" {
  name                = var.web_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  #sku = "Basic"
}

#WEB NIC AND VM

resource "azurerm_network_interface" "web-nic" {
  name                = var.web_network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "public_configuration1"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web-ip.id
  }
}

resource "azurerm_linux_virtual_machine" "web-vm" {
  name                = var.web_virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_DC1ds_v3"
  admin_username      = "web-adminuser"
  network_interface_ids = [
    var.web_network_interface_name
  ]

  admin_ssh_key {
    username   = "web-adminuser"
    public_key = data.azurerm_key_vault_secret.ssh_public_key.value
  }
  #admin_password = "Password@12345"
  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_network_interface_security_group_association" "nic_group_web" {
  network_interface_id = azurerm_network_interface.web-nic.id
  network_security_group_id = var.web_nsg_id
}

#APP NIC AND VM

resource "azurerm_network_interface" "app-nic" {
  name                = var.app_network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "app_configuration1"
    subnet_id                     = var.app_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "app-vm" {
  name                = var.app_virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_DC1ds_v3"
  admin_username      = "app-adminuser"
  network_interface_ids = null

  admin_ssh_key {
    username   = "app-adminuser"
    public_key = data.azurerm_key_vault_secret.ssh_public_key.value
  }
  #admin_password = "Password@12345"
  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_network_interface_security_group_association" "nic_group_app" {
  network_interface_id = azurerm_network_interface.app-nic.id
  network_security_group_id = var.app_nsg_id
}