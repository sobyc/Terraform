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



data "azurerm_resource_group" "example" {
  name = "test-rg1"

}

output "id" {
  value = data.azurerm_resource_group.example.id
}


output "rgid" {
    value = module.rg.rgid
  
}