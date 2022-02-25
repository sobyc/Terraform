provider "azurerm" {

  features {

  }
}

resource "azurerm_resource_group" "hubrg" {
  name     = var.hubrg
  location = var.location
}

resource "azurerm_resource_group" "spoke1rg" {
  name     = var.spoke1rg
  location = var.location
}


resource "azurerm_resource_group" "spoke2rg" {
  name     = var.spoke2rg
  location = var.location
}

resource "azurerm_resource_group" "spoke3rg" {
  name     = var.spoke3rg
  location = var.location
}

resource "azurerm_virtual_network" "hubvnet" {
  name                = var.hubvnet
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name
  address_space       = ["${var.cidrvnet[0]}"]
}

resource "azurerm_subnet" "mgmthubsnet" {
  name                 = var.snethubmgmt
  resource_group_name  = azurerm_resource_group.hubrg.name
  virtual_network_name = azurerm_virtual_network.hubvnet.name
  address_prefixes     = ["${var.cidrhub[0]}"]
  depends_on = [
    azurerm_virtual_network.hubvnet
  ]
}

resource "azurerm_network_security_group" "nsghubmgmt" {
  name                = var.nsghubmgmt
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name
  depends_on = [
    azurerm_subnet.mgmthubsnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansghubmgmt" {
  subnet_id                 = azurerm_subnet.mgmthubsnet.id
  network_security_group_id = azurerm_network_security_group.nsghubmgmt.id
  depends_on = [
    azurerm_network_security_group.nsghubmgmt
  ]
}



resource "azurerm_subnet" "adhubsnet" {
  name                 = var.snethubad
  resource_group_name  = azurerm_resource_group.hubrg.name
  virtual_network_name = azurerm_virtual_network.hubvnet.name
  address_prefixes     = ["${var.cidrhub[1]}"]
  depends_on = [
    azurerm_virtual_network.hubvnet
  ]
}

resource "azurerm_network_security_group" "nsghubad" {
  name                = var.nsghubad
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name
  depends_on = [
    azurerm_subnet.adhubsnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansghubad" {
  subnet_id                 = azurerm_subnet.adhubsnet.id
  network_security_group_id = azurerm_network_security_group.nsghubad.id
  depends_on = [
    azurerm_network_security_group.nsghubad
  ]
}


resource "azurerm_subnet" "sechubsnet" {
  name                 = var.snethubsec
  resource_group_name  = azurerm_resource_group.hubrg.name
  virtual_network_name = azurerm_virtual_network.hubvnet.name
  address_prefixes     = ["${var.cidrhub[2]}"]
  depends_on = [
    azurerm_virtual_network.hubvnet
  ]
}

resource "azurerm_network_security_group" "nsghubsec" {
  name                = var.nsghubsec
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name
  depends_on = [
    azurerm_subnet.sechubsnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansghubsec" {
  subnet_id                 = azurerm_subnet.sechubsnet.id
  network_security_group_id = azurerm_network_security_group.nsghubsec.id
  depends_on = [
    azurerm_network_security_group.nsghubsec
  ]
}



resource "azurerm_virtual_network" "spoke1vnet" {
  name                = var.spoke1vnet
  location            = azurerm_resource_group.spoke1rg.location
  resource_group_name = azurerm_resource_group.spoke1rg.name
  address_space       = ["${var.cidrvnet[1]}"]
}

resource "azurerm_subnet" "webspoke1snet" {
  name                 = var.snetspoke1web
  resource_group_name  = azurerm_resource_group.spoke1rg.name
  virtual_network_name = azurerm_virtual_network.spoke1vnet.name
  address_prefixes     = ["${var.cidrspoke1[0]}"]
  depends_on = [
    azurerm_virtual_network.spoke1vnet
  ]
}


resource "azurerm_network_security_group" "nsgspoke1web" {
  name                = var.nsgspoke1web
  location            = azurerm_resource_group.spoke1rg.location
  resource_group_name = azurerm_resource_group.spoke1rg.name
  depends_on = [
    azurerm_subnet.webspoke1snet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke1web" {
  subnet_id                 = azurerm_subnet.webspoke1snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke1web.id
  depends_on = [
    azurerm_network_security_group.nsgspoke1web
  ]
}




resource "azurerm_subnet" "appspoke1snet" {
  name                 = var.snetspoke1app
  resource_group_name  = azurerm_resource_group.spoke1rg.name
  virtual_network_name = azurerm_virtual_network.spoke1vnet.name
  address_prefixes     = ["${var.cidrspoke1[1]}"]
  depends_on = [
    azurerm_virtual_network.spoke1vnet
  ]
}


resource "azurerm_network_security_group" "nsgspoke1app" {
  name                = var.nsgspoke1app
  location            = azurerm_resource_group.spoke1rg.location
  resource_group_name = azurerm_resource_group.spoke1rg.name
  depends_on = [
    azurerm_subnet.appspoke1snet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke1app" {
  subnet_id                 = azurerm_subnet.appspoke1snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke1app.id
  depends_on = [
    azurerm_network_security_group.nsgspoke1app
  ]
}



resource "azurerm_subnet" "dbspoke1snet" {
  name                 = var.snetspoke1db
  resource_group_name  = azurerm_resource_group.spoke1rg.name
  virtual_network_name = azurerm_virtual_network.spoke1vnet.name
  address_prefixes     = ["${var.cidrspoke1[2]}"]
  depends_on = [
    azurerm_virtual_network.spoke1vnet
  ]
}



resource "azurerm_network_security_group" "nsgspoke1db" {
  name                = var.nsgspoke1db
  location            = azurerm_resource_group.spoke1rg.location
  resource_group_name = azurerm_resource_group.spoke1rg.name
  depends_on = [
    azurerm_subnet.dbspoke1snet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke1db" {
  subnet_id                 = azurerm_subnet.dbspoke1snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke1db.id
  depends_on = [
    azurerm_network_security_group.nsgspoke1db
  ]
}




resource "azurerm_virtual_network" "spoke2vnet" {
  name                = var.spoke2vnet
  location            = azurerm_resource_group.spoke2rg.location
  resource_group_name = azurerm_resource_group.spoke2rg.name
  address_space       = ["${var.cidrvnet[2]}"]
}




resource "azurerm_subnet" "webspoke2snet" {
  name                 = var.snetspoke2web
  resource_group_name  = azurerm_resource_group.spoke2rg.name
  virtual_network_name = azurerm_virtual_network.spoke2vnet.name
  address_prefixes     = ["${var.cidrspoke2[0]}"]
  depends_on = [
    azurerm_virtual_network.spoke2vnet
  ]
}

resource "azurerm_network_security_group" "nsgspoke2web" {
  name                = var.nsgspoke2web
  location            = azurerm_resource_group.spoke2rg.location
  resource_group_name = azurerm_resource_group.spoke2rg.name
  depends_on = [
    azurerm_subnet.webspoke2snet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke2web" {
  subnet_id                 = azurerm_subnet.webspoke2snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke2web.id
  depends_on = [
    azurerm_network_security_group.nsgspoke2web
  ]
}


resource "azurerm_subnet" "appspoke2snet" {
  name                 = var.snetspoke2app
  resource_group_name  = azurerm_resource_group.spoke2rg.name
  virtual_network_name = azurerm_virtual_network.spoke2vnet.name
  address_prefixes     = ["${var.cidrspoke2[1]}"]
  depends_on = [
    azurerm_virtual_network.spoke2vnet
  ]
}

resource "azurerm_network_security_group" "nsgspoke2app" {
  name                = var.nsgspoke2app
  location            = azurerm_resource_group.spoke2rg.location
  resource_group_name = azurerm_resource_group.spoke2rg.name
  depends_on = [
    azurerm_subnet.appspoke2snet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke2app" {
  subnet_id                 = azurerm_subnet.appspoke2snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke2app.id
  depends_on = [
    azurerm_network_security_group.nsgspoke2app
  ]
}



resource "azurerm_subnet" "dbspoke2snet" {
  name                 = var.snetspoke2db
  resource_group_name  = azurerm_resource_group.spoke2rg.name
  virtual_network_name = azurerm_virtual_network.spoke2vnet.name
  address_prefixes     = ["${var.cidrspoke2[2]}"]
  depends_on = [
    azurerm_virtual_network.spoke2vnet
  ]
}



resource "azurerm_network_security_group" "nsgspoke2db" {
  name                = var.nsgspoke2db
  location            = azurerm_resource_group.spoke2rg.location
  resource_group_name = azurerm_resource_group.spoke2rg.name
  depends_on = [
    azurerm_subnet.dbspoke2snet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke2db" {
  subnet_id                 = azurerm_subnet.dbspoke2snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke2db.id
  depends_on = [
    azurerm_network_security_group.nsgspoke2db
  ]
}




resource "azurerm_virtual_network" "spoke3vnet" {
  name                = var.spoke3vnet
  location            = azurerm_resource_group.spoke3rg.location
  resource_group_name = azurerm_resource_group.spoke3rg.name
  address_space       = ["${var.cidrvnet[3]}"]
}

resource "azurerm_subnet" "webspoke3snet" {
  name                 = var.snetspoke3web
  resource_group_name  = azurerm_resource_group.spoke3rg.name
  virtual_network_name = azurerm_virtual_network.spoke3vnet.name
  address_prefixes     = ["${var.cidrspoke3[0]}"]
  depends_on = [
    azurerm_virtual_network.spoke3vnet
  ]
}


resource "azurerm_network_security_group" "nsgspoke3web" {
  name                = var.nsgspoke3web
  location            = azurerm_resource_group.spoke3rg.location
  resource_group_name = azurerm_resource_group.spoke3rg.name
  depends_on = [
    azurerm_subnet.webspoke3snet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke3web" {
  subnet_id                 = azurerm_subnet.webspoke3snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke3web.id
  depends_on = [
    azurerm_network_security_group.nsgspoke3web
  ]
}


resource "azurerm_subnet" "appspoke3snet" {
  name                 = var.snetspoke3app
  resource_group_name  = azurerm_resource_group.spoke3rg.name
  virtual_network_name = azurerm_virtual_network.spoke3vnet.name
  address_prefixes     = ["${var.cidrspoke3[1]}"]
  depends_on = [
    azurerm_virtual_network.spoke3vnet
  ]
}


resource "azurerm_network_security_group" "nsgspoke3app" {
  name                = var.nsgspoke3app
  location            = azurerm_resource_group.spoke3rg.location
  resource_group_name = azurerm_resource_group.spoke3rg.name
  depends_on = [
    azurerm_subnet.appspoke3snet
  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke3app" {
  subnet_id                 = azurerm_subnet.appspoke3snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke3app.id
  depends_on = [
    azurerm_network_security_group.nsgspoke3app
  ]
}



resource "azurerm_subnet" "dbspoke3snet" {
  name                 = var.snetspoke3db
  resource_group_name  = azurerm_resource_group.spoke3rg.name
  virtual_network_name = azurerm_virtual_network.spoke3vnet.name
  address_prefixes     = ["${var.cidrspoke3[2]}"]
  depends_on = [
    azurerm_virtual_network.spoke3vnet
  ]
}

resource "azurerm_network_security_group" "nsgspoke3db" {
  name                = var.nsgspoke3db
  location            = azurerm_resource_group.spoke3rg.location
  resource_group_name = azurerm_resource_group.spoke3rg.name
  depends_on = [
    azurerm_subnet.dbspoke3snet

  ]
}

resource "azurerm_subnet_network_security_group_association" "ansgspoke3db" {
  subnet_id                 = azurerm_subnet.dbspoke3snet.id
  network_security_group_id = azurerm_network_security_group.nsgspoke3db.id
  depends_on = [
    azurerm_network_security_group.nsgspoke3db
  ]
}

resource "azurerm_virtual_network_peering" "hubspoke1" {
  name                         = "${var.hubvnet}to${var.spoke1vnet}"
  resource_group_name          = azurerm_resource_group.hubrg.name
  virtual_network_name         = azurerm_virtual_network.hubvnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke1vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on = [
    azurerm_virtual_network.hubvnet,
    azurerm_virtual_network.spoke1vnet
  ]
}

resource "azurerm_virtual_network_peering" "spoke1hub" {
  name                         = "${var.spoke1vnet}to${var.hubvnet}"
  resource_group_name          = azurerm_resource_group.spoke1rg.name
  virtual_network_name         = azurerm_virtual_network.spoke1vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hubvnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on = [
    azurerm_virtual_network.hubvnet,
    azurerm_virtual_network.spoke1vnet
  ]
}


resource "azurerm_virtual_network_peering" "hubspoke2" {
  name                         = "${var.hubvnet}to${var.spoke2vnet}"
  resource_group_name          = azurerm_resource_group.hubrg.name
  virtual_network_name         = azurerm_virtual_network.hubvnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke2vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on = [
    azurerm_virtual_network.hubvnet,
    azurerm_virtual_network.spoke2vnet
  ]
}

resource "azurerm_virtual_network_peering" "spoke2hub" {
  name                         = "${var.spoke2vnet}to${var.hubvnet}"
  resource_group_name          = azurerm_resource_group.spoke2rg.name
  virtual_network_name         = azurerm_virtual_network.spoke2vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hubvnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on = [
    azurerm_virtual_network.hubvnet,
    azurerm_virtual_network.spoke2vnet
  ]
}


resource "azurerm_virtual_network_peering" "hubspoke3" {
  name                         = "${var.hubvnet}to${var.spoke3vnet}"
  resource_group_name          = azurerm_resource_group.hubrg.name
  virtual_network_name         = azurerm_virtual_network.hubvnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke3vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on = [
    azurerm_virtual_network.hubvnet,
    azurerm_virtual_network.spoke3vnet
  ]
}

resource "azurerm_virtual_network_peering" "spoke3hub" {
  name                         = "${var.spoke3vnet}to${var.hubvnet}"
  resource_group_name          = azurerm_resource_group.spoke3rg.name
  virtual_network_name         = azurerm_virtual_network.spoke3vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hubvnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  depends_on = [
    azurerm_virtual_network.hubvnet,
    azurerm_virtual_network.spoke3vnet
  ]
}




