provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rgname" {
  name     = var.rgname
  location = var.location
}


resource "azurerm_virtual_network" "vnetinf" {
  name                = "vnet-we-inf-01"
  location            = azurerm_resource_group.rgname.location
  resource_group_name = azurerm_resource_group.rgname.name
  address_space       = ["172.25.0.0/24"]
  depends_on = [
    azurerm_resource_group.rgname
  ]

}


resource "azurerm_subnet" "subnet-1" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.rgname.name
  virtual_network_name = azurerm_virtual_network.vnetinf.name
  address_prefixes     = ["172.25.0.0/28"]

    depends_on = [
    azurerm_virtual_network.vnetinf
  ]
}