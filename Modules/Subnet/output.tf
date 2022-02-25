output "snetcidr" {
  value = azurerm_subnet.subnet.address_prefix
}

output "snetid" {
  value = azurerm_subnet.subnet.id
}