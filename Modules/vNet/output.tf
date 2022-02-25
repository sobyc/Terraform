
output "vnetcidr" {
  value = azurerm_virtual_network.vnet.address_space
}

output "vnetid" {
  value = azurerm_virtual_network.vnet.id
}