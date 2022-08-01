


resource "azurerm_virtual_network" "vnet" {
    resource_group_name = "${var.rgname}"
    location = "${var.location}"
    name = "${var.vnetname}"
    address_space = "${var.vnetcidr}"
    tags = var.tags
}

