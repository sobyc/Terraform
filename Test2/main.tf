provider "azurerm" {
  features {

  }
}


data "azurerm_resource_group" "rg-test" {
  name = "test-rg1"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = data.azurerm_resource_group.rg-test.RG_Location
  resource_group_name = data.azurerm_resource_group.rg-test.RG_Name
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