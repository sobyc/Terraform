provider "azurerm" {

  features {

  }
}

resource "azurerm_resource_group" "hubrg" {
  name     = var.hubrg
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "spoke1rg" {
  name     = var.spoke1rg
  location = var.location
  tags     = var.tags
}


resource "azurerm_resource_group" "spoke2rg" {
  name     = var.spoke2rg
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "spoke3rg" {
  name     = var.spoke3rg
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "hubvnet" {
  name                = var.hubvnet
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name
  address_space       = ["${var.cidrvnet[0]}"]
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
  depends_on = [
    azurerm_subnet.adhubsnet
  ]
}

resource "azurerm_network_security_rule" "rdp-rule" {
  name                        = "rdp-rule-01"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hubrg.name
  network_security_group_name = azurerm_network_security_group.nsghubad.name
}

resource "azurerm_network_security_rule" "http-rule" {
  name                        = "http-rule-01"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.hubrg.name
  network_security_group_name = azurerm_network_security_group.nsghubad.name
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
  tags                = var.tags
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

resource "azurerm_subnet" "appgwsnet" {
  name                 = var.appgwsnet
  resource_group_name  = azurerm_resource_group.hubrg.name
  virtual_network_name = azurerm_virtual_network.hubvnet.name
  address_prefixes     = ["${var.cidrhub[3]}"]
  depends_on = [
    azurerm_virtual_network.hubvnet
  ]
}

resource "azurerm_virtual_network" "spoke1vnet" {
  name                = var.spoke1vnet
  location            = azurerm_resource_group.spoke1rg.location
  resource_group_name = azurerm_resource_group.spoke1rg.name
  address_space       = ["${var.cidrvnet[1]}"]
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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
  tags                = var.tags
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


resource "azurerm_public_ip" "lb-pip" {
  name                = "pip-ci-azclass123-lb-01"
  resource_group_name = azurerm_resource_group.hubrg.name
  location            = azurerm_resource_group.hubrg.location
  allocation_method   = "Static"
  domain_name_label   = "azclass123"
  sku = "standard"
  tags = {
    environment = "Production"
  }
}

output "fqdn" {
  description = "Fully qualified domain name of the A DNS record associated with the public IP. domain_name_label must be specified to get the fqdn. This is the concatenation of the domain_name_label and the regionalized DNS zone."
  value       = azurerm_public_ip.lb-pip.fqdn

}


resource "azurerm_public_ip" "lb-pip-02" {
  name                = "pip-ci-azclass123-lb-02"
  resource_group_name = azurerm_resource_group.hubrg.name
  location            = azurerm_resource_group.hubrg.location
  allocation_method   = "Dynamic"
  domain_name_label   = "azclass321"
  sku = "Basic"
  tags = {
    environment = "Production"
  }
}

output "fqdn-02" {
  description = "Fully qualified domain name of the A DNS record associated with the public IP. domain_name_label must be specified to get the fqdn. This is the concatenation of the domain_name_label and the regionalized DNS zone."
  value       = azurerm_public_ip.lb-pip.fqdn

}

resource "azurerm_availability_set" "as-azclass123" {
  name                = "as-ci-azclass123-01"
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name

  tags = {
    environment = "Production"
  }
}



resource "azurerm_network_interface" "nic-azclass123" {
  name                = "nic-ci-azclass123-01"
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.adhubsnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm01" {
  name                = "vm-ci-hub-w-01"
  resource_group_name = azurerm_resource_group.hubrg.name
  location            = azurerm_resource_group.hubrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Password@123"
  network_interface_ids = [
    azurerm_network_interface.nic-azclass123.id,
  ]
  availability_set_id = azurerm_availability_set.as-azclass123.id

  os_disk {
    caching              = "ReadWrite"
    name                 = "vm-ci-hub-w-01-osdisk-01"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}




resource "azurerm_network_interface" "nic-azclass123-02" {
  name                = "nic-ci-azclass123-02"
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.adhubsnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm02" {
  name                = "vm-ci-hub-w-02"
  resource_group_name = azurerm_resource_group.hubrg.name
  location            = azurerm_resource_group.hubrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Password@123"
  network_interface_ids = [
    azurerm_network_interface.nic-azclass123-02.id,
  ]
  availability_set_id = azurerm_availability_set.as-azclass123.id

  os_disk {
    caching              = "ReadWrite"
    name                 = "vm-ci-hub-w-02-osdisk-01"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}


resource "azurerm_lb" "lb-azclass123" {
  name                = "lb-ci-azclass123-01"
  location            = azurerm_resource_group.hubrg.location
  resource_group_name = azurerm_resource_group.hubrg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb-pip-02.id
  }
}

resource "azurerm_lb_backend_address_pool" "bp-01" {
  loadbalancer_id     = azurerm_lb.lb-azclass123.id
  name                = "bp-01"
  depends_on = [
    azurerm_lb.lb-azclass123,
    azurerm_availability_set.as-azclass123
  ]
}

resource "azurerm_network_interface_backend_address_pool_association" "bp-association-01" {
  network_interface_id    = azurerm_network_interface.nic-azclass123.id
  ip_configuration_name   = "ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bp-01.id
}

resource "azurerm_network_interface_backend_address_pool_association" "bp-association-02" {
  network_interface_id    = azurerm_network_interface.nic-azclass123-02.id
  ip_configuration_name   = "ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bp-01.id
}

resource "azurerm_lb_probe" "hp-01" {
  loadbalancer_id = azurerm_lb.lb-azclass123.id
  resource_group_name            = azurerm_resource_group.hubrg.name
  name            = "rdp-running-probe"
  port            = 3389
  depends_on = [
    azurerm_lb.lb-azclass123
  ]
}

resource "azurerm_lb_rule" "lbrule-01" {
  loadbalancer_id                = azurerm_lb.lb-azclass123.id
  resource_group_name            = azurerm_resource_group.hubrg.name
  name                           = "LBRule-01"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bp-01.id
  probe_id = azurerm_lb_probe.hp-01.id
  depends_on = [
    azurerm_lb.lb-azclass123,
    azurerm_availability_set.as-azclass123,
    azurerm_lb_probe.hp-01
  ]
}

resource "azurerm_lb_rule" "lbrule-02" {
  loadbalancer_id                = azurerm_lb.lb-azclass123.id
  resource_group_name            = azurerm_resource_group.hubrg.name
  name                           = "LBRule-02"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id       = azurerm_lb_backend_address_pool.bp-01.id
  probe_id = azurerm_lb_probe.hp-01.id
  depends_on = [
    azurerm_lb.lb-azclass123,
    azurerm_availability_set.as-azclass123,
    azurerm_lb_probe.hp-01
  ]
}



