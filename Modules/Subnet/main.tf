resource "azurerm_subnet" "subnet" {
  name                 = var.azurerm_subnet
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = "${var.cidrsnet}"
  tags = var.tags
}

