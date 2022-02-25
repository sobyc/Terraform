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


  subnet {
    name           = "GatewaySubnet"
    address_prefix = "172.25.0.0/26"
  }

  subnet {
    name           = "snet-we-inf-ad-01"
    address_prefix = "172.25.0.64/28"

  }
  subnet {
    name           = "snet-we-inf-mgmt-01"
    address_prefix = "172.25.0.96/28"
  }

  

  tags = {
    environment = "Infra"
  }
}

