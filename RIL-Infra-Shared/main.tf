terraform {
  backend "azurerm" {
    resource_group_name  = "Sourabh-Migration-RG"
    storage_account_name = "sourabhsa101"
    container_name       = "sharedstate"
    key                  = "shared.terraform.tfstate"

  }
}


provider "azurerm" {
  features {
    
  }
}
/*
locals {
  tags = {
      "Environment" = "Shared"
      "Location" = "Central India"
      "Cost Center" = "RIL"
  }

}
*/

module "Resource_Group" {
  source   = "../Modules/Resource_Group"
  rgname   = "${var.hubvnetrgname}"
  location = "${var.location}"
  tags = {
    Environment = "Prod"
    Business_Unit = "Finance"
  }
}

module "vNet" {
  source        = "../Modules/vNet"
  rgname        = "${var.hubvnetrgname}"
  location      = "${var.location}"
  vnetname      = "${var.vnetname}"
  vnetcidr       = ["${var.vnetcidr[0]}"]
  depends_on = [
    module.Resource_Group
  ]
}

resource "azurerm_virtual_network_dns_servers" "dns" {
  virtual_network_id = module.vNet.vnetid
  dns_servers = ["172.20.0.120"]
  depends_on = [
    module.vNet
  ]
}