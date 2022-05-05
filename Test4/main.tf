

data "azurerm_resource_group" "rg-test" {
  name = "test-rg1"

}

data "azurerm_resource_group" "rg-test2" {
  name = "test-rg2"

}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = data.azurerm_resource_group.rg-test.location
  resource_group_name = data.azurerm_resource_group.rg-test.name
  address_space       = ["12.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "12.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "12.0.2.0/24"
  }

  tags = {
    environment = "Production"
  }
}


resource "azurerm_virtual_network" "vnet-2" {
  name                = "vnet-hub"
  location            = data.azurerm_resource_group.rg-test2.location
  resource_group_name = data.azurerm_resource_group.rg-test2.name
  address_space       = ["12.2.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "12.2.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "12.2.2.0/24"
  }

  tags = {
    environment = "Dev"
  }
}
