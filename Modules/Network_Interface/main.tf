resource "azurerm_network_interface" "nic" {
  name                = "${var.nicname}"
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


output "nicid" {
  value = azurerm_network_interface.nic.id
}