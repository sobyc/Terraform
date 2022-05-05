terraform {
  backend "azurerm" {
    resource_group_name  = "state-rg"
    storage_account_name = "sastatefilesa"
    container_name       = "state-test"
    key                  = "test.terraform.tfstate"

  }
}


provider "azurerm" {
  features {

  }
}

module "rg" {
  source = "../Modules/Resource_Group"
  rgname = "test-rg1"
  location = "westeurope"
}


module "rg2" {
  source = "../Modules/Resource_Group"
  rgname = "test-rg2"
  location = "westeurope"
}


data "azurerm_resource_group" "example" {
  name = "test-rg1"
  depends_on = [
    module.rg
  ]
}

output "RG_Name" {
  value = data.azurerm_resource_group.example.name
}

output "RG_Location" {
  value = data.azurerm_resource_group.example.location
}


output "rgid" {
    value = module.rg.rgid
  
}