/*

resource "azurerm_subnet" "subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = "${var.cidrsnet}"

}

*/
# The public IP of the Bastion resource 
resource "azurerm_public_ip" "pubip" {
  name                = "${var.pip}"
  rgname              = "${var.rgname}"
  location            = "${var.location}"
  allocation_method   = var.ip_allocation
  sku                 = var.sku

}

# create bastion host
resource "azurerm_bastion_host" "bastion" {
  name                = "${var.bastionhost}"
  rgname              = "${var.rgname}"
  location            = "${var.location}"
  tags                = var.bastion_tags


  ip_configuration {
    name                 = "${var.rgname}-configuration"
    subnet_id            = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.pubip.id
  }

}