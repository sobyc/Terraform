output "name" {
    value = "My name is ${var.name}"
}

output "vnet" {
  value = azurerm_virtual_network.hubvnet.address_space
}