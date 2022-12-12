variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_virtual_network" "VNet11" {
  name                = "${var.vmname}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.oguzhan_resource_group.location
  resource_group_name = azurerm_resource_group.oguzhan_resource_group.name
}

resource "azurerm_subnet" "subnet11" {
  name                 = "subnet11"
  resource_group_name  = azurerm_resource_group.oguzhan_resource_group.name
  virtual_network_name = azurerm_virtual_network.VNet11.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "NIC11" {
  name                = "${var.vmname}-nic"
  location            = azurerm_resource_group.oguzhan_resource_group.location
  resource_group_name = azurerm_resource_group.oguzhan_resource_group.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet11.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm11" {
  name                  = var.vmname
  location              = azurerm_resource_group.oguzhan_resource_group.location
  resource_group_name   = azurerm_resource_group.oguzhan_resource_group.name
  network_interface_ids = [azurerm_network_interface.NIC11.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "var.vmname"
    admin_username = "var.vm_user_name"
    admin_password = "var.vmPassword"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}