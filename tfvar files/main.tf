resource "azurerm_resource_group" "hubrg" {
  name     = "test-rg"
  location = "east US"
}


resource "azurerm_virtual_network" "hubvnet" {
  name                = "hubvnet"
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name
  address_space       = ["${var.cidrhub[1]}"]
}