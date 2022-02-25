provider "azurerm" {
  features {

  }
}

module "rg" {
  source = "../Modules/Resource_Group"
  rgname = "test-rg"
  location = "westeurope"
}


output "rgid" {
    value = module.rg.rgid
  
}