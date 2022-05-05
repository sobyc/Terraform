
provider "azurerm" {
  features {

  }
}

data "azurerm_virtual_network" "vnet-1" {
  name = "example-network"
  resource_group_name = "test-rg1"
}

data "azurerm_virtual_network" "vnet-2" {
  name = "vnet-hub"
  resource_group_name = "test-rg2"
}


resource "azurerm_virtual_network_peering" "peering-1" {
  name                      = "devtohub"
  resource_group_name       = "test-rg1"
  virtual_network_name      = data.azurerm_virtual_network.vnet-1.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet-2.id
}



resource "azurerm_virtual_network_peering" "peering-2" {
  name                      = "hubtodev"
  resource_group_name       = "test-rg2"
  virtual_network_name      = data.azurerm_virtual_network.vnet-2.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet-1.id
}