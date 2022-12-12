
# Create a resource group
resource "azurerm_resource_group" "oguzhan_resource_group" {
  name     = var.RGname
  location = var.location
}