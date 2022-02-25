provider "azurerm" {
    features {
      
    }
  
}


resource "azurerm_resource_group" "rgname" {
  name     = "${var.rgname}"
  location = "${var.location}"
}