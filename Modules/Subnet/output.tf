output "snetcidr" {
  value = azurerm_subnet.subnet.address_prefixes
}

output "snetid" {
  value = azurerm_subnet.subnet.id
}