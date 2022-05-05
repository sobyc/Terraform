terraform {
  backend "azurerm" {
    resource_group_name  = "rg-eus-inf-01"
    storage_account_name = "sastatefilesa1"
    container_name       = "sharedstatewus"
    key                  = "sharedwus.terraform.tfstate"

  }
}

provider "azurerm" {
  features {

  }
}

module "Resource_Group" {
  source   = "../Modules/Resource_Group"
  rgname   = "${var.rgname}"
  location = "${var.location}"

}

module "vnet" {
  source   = "../Modules/vNet"
  rgname   = "${var.rgname}"
  location = "${var.location}"
  vnetname = "${var.vnetname}"
  vnetcidr = ["${var.vnetcidr[0]}"]
  depends_on = [
    module.Resource_Group
  ]
}

module "snet1" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet1name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[0]}"]

  depends_on = [
    module.vnet
  ]
}

module "snet2" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet2name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[1]}"]

  depends_on = [
    module.vnet
  ]
}

module "snet3" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet3name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[2]}"]

  depends_on = [
    module.vnet
  ]
}

module "snet4" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet4name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[3]}"]

  depends_on = [
    module.vnet
  ]
}

module "snet5" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet5name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[4]}"]

  depends_on = [
    module.vnet
  ]
}

module "snet6" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet6name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[5]}"]

  depends_on = [
    module.vnet
  ]
}


resource "azurerm_subnet" "snet7" {
  name           = "AzureBastionSubnet"
  resource_group_name  = "${var.rgname}"
  virtual_network_name = "${var.vnetname}"
  address_prefixes        = ["${var.snetcidr[6]}"]

  depends_on = [
    module.vnet
  ]
}

resource "azurerm_public_ip" "bastionhost-pip" {
  name                = "AzureBastionSubnet-pip"
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    module.Resource_Group
  ]  
}

resource "azurerm_bastion_host" "bastionhost" {
  name                = "bastionhost"
  location            = "${var.location}"
  resource_group_name = "${var.rgname}"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.snet7.id
    public_ip_address_id = azurerm_public_ip.bastionhost-pip.id
  }
  depends_on = [
    module.Resource_Group
  ]  
}


module "snet8" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet8name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[7]}"]

  depends_on = [
    module.vnet
  ]
}

module "snet9" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet9name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[8]}"]

  depends_on = [
    module.vnet
  ]
}

module "snet10" {
  source         = "../Modules/Subnet"
  azurerm_subnet = "${var.snet10name}"
  rgname         = "${var.rgname}"
  vnetname       = "${var.vnetname}"
  cidrsnet       = ["${var.snetcidr[9]}"]

  depends_on = [
    module.vnet
  ]
}


module "nsgsnet1" {
  source     = "../Modules/Network_Security_Group"
  location   = "${var.location}"
  rgname     = "${var.rgname}"
  nsgdevsnet = "${var.nsgsnet1}"

  depends_on = [
    module.snet1
  ]
}

module "nsgsnet2" {
  source     = "../Modules/Network_Security_Group"
  location   = "${var.location}"
  rgname     = "${var.rgname}"
  nsgdevsnet = "${var.nsgsnet2}"

  depends_on = [
    module.snet2
  ]
}

module "nsgsnet3" {
  source     = "../Modules/Network_Security_Group"
  location   = "${var.location}"
  rgname     = "${var.rgname}"
  nsgdevsnet = "${var.nsgsnet3}"

  depends_on = [
    module.snet3
  ]
}



resource "azurerm_subnet_network_security_group_association" "nsgsnet1association" {
  subnet_id                 = module.snet2.snetid 
  network_security_group_id = module.nsgsnet1.nsg-id
  depends_on = [
    module.nsgsnet1,module.snet2
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsgsnet2association" {
  subnet_id                 = module.snet3.snetid 
  network_security_group_id = module.nsgsnet2.nsg-id
  depends_on = [
    module.nsgsnet2,module.snet3
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsgsnet3association" {
  subnet_id                 = module.snet4.snetid 
  network_security_group_id = module.nsgsnet3.nsg-id
  depends_on = [
    module.nsgsnet3,module.snet4
  ]
}
