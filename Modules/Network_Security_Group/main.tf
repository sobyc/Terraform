resource "azurerm_network_security_group" "nsgsnet" {
  name                = var.nsgdevsnet
  location            = var.location
  resource_group_name = var.rgname
}

output "nsg-id" {

  value = azurerm_network_security_group.nsgsnet.id
  
}