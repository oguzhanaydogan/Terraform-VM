resource "azurerm_storage_account" "oguzhan_storage_account" {
  name                     = "oguzhanstorageacc"
  resource_group_name      = azurerm_resource_group.oguzhan_resource_group.name
  location                 = azurerm_resource_group.oguzhan_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}