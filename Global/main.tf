terraform {
  backend "azurerm" {
    resource_group_name  = "state-rg"
    storage_account_name = "sastatefilesa"
    container_name       = "state-global"
    key                  = "global.terraform.tfstate"

  }
}

provider "azurerm" {
  features {

  }
}

data "azurerm_virtual_network" "vnet-hub" {
  name = "vnet-eus-inf-01"
  resource_group_name = "rg-eus-inf-01"
}

data "azurerm_virtual_network" "vnet-dev" {
  name = "vnet-eus-dev-01"
  resource_group_name = "rg-eus-dev-01"
}


resource "azurerm_virtual_network_peering" "peering-1" {
  name                      = "hubtodev"
  resource_group_name       = "vnet-eus-inf-01"
  virtual_network_name      = data.azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet-dev.id
}



resource "azurerm_virtual_network_peering" "peering-2" {
  name                      = "devtohub"
  resource_group_name       = "vnet-eus-dev-01"
  virtual_network_name      = data.azurerm_virtual_network.vnet-dev.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet-hub.id
}



data "azurerm_virtual_network" "vnet-hub" {
  name = "vnet-eus-inf-01"
  resource_group_name = "rg-eus-inf-01"
}

data "azurerm_virtual_network" "vnet-nprod" {
  name = "vnet-eus-nprod-01"
  resource_group_name = "rg-eus-nprod-01"
}


resource "azurerm_virtual_network_peering" "peering-3" {
  name                      = "hubtonprod"
  resource_group_name       = "vnet-eus-inf-01"
  virtual_network_name      = data.azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet-nprod.id
}



resource "azurerm_virtual_network_peering" "peering-4" {
  name                      = "nprodtohub"
  resource_group_name       = "rg-eus-nprod-01"
  virtual_network_name      = data.azurerm_virtual_network.vnet-nprod.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet-hub.id
}

data "azurerm_virtual_network" "vnet-hub" {
  name = "vnet-eus-inf-01"
  resource_group_name = "rg-eus-inf-01"
}

data "azurerm_virtual_network" "vnet-dev" {
  name = "vnet-eus-prod-01"
  resource_group_name = "rg-eus-prod-01"
}


resource "azurerm_virtual_network_peering" "peering-5" {
  name                      = "hubtoprod"
  resource_group_name       = "vnet-eus-inf-01"
  virtual_network_name      = data.azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet-prod.id
}



resource "azurerm_virtual_network_peering" "peering-6" {
  name                      = "prodtohub"
  resource_group_name       = "rg-eus-prod-01"
  virtual_network_name      = data.azurerm_virtual_network.vnet-prod.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet-hub.id
}



