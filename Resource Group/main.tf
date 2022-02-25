provider "azurerm" {

  features {
    
  }
}


resource "azurerm_resource_group" "RG" {
  name     = "${var.RG}"
  location = "${var.Location}"
  tags = {
    "Environment" = "Prod"
    "Cost Centre" = "YTV"
    "Owner" = "Sourabh"
    "Resource" = "Resource Group"
    "Location" = "South India"
  }
}

resource "azurerm_network_security_group" "NSG-HUB-MGMT" {
name                = "${var.NSG1}"
location            = azurerm_resource_group.RG.location
resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet}"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["172.22.0.0/24"]
  dns_servers         = ["172.22.0.4" , "172.22.0.5"]

  subnet {
    name           = "sob-snet-mgmt-hub-01"
    address_prefix = "${var.Hubsubnet[0]}"
 #   security_group = azurerm_network_security_group.NSG-HUB-MGMT.id
  }

  subnet {
    name           = "sob-snet-ad-hub-01"
    address_prefix = "${var.Hubsubnet[1]}"
  }

  subnet {
    name           = "sob-snet-sec-hub-01"
    address_prefix = "${var.Hubsubnet[2]}"
  }

  subnet {
    name           = "GatewaySubnet"
    address_prefix = "${var.Hubsubnet[3]}"
  }

  subnet {
    name           = "AzureFirewallSubnet"
    address_prefix = "${var.Hubsubnet[4]}"
  }

  tags = {
    "Environment" = "Production"
    "Resource" = "VNET"
    "Cost Center" = "YTV"
    "Location" = "South India"
  }
}

/*
resource "azurerm_subnet" "SNET-HUB-MGMT" {
name                 = "sob-snet-mgmt-hub-01"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes     = ["172.22.0.0/28"]
}

resource "azurerm_subnet" "SNET-HUB-AD" {
name                 = "sob-snet-ad-hub-01"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes     = ["172.22.0.16/28"]
}



resource "azurerm_subnet" "SNET-HUB-AD" {
name                 = "sob-snet-ad-hub-01"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes     = ["172.22.0.16/28"]
}

resource "azurerm_subnet" "SNET-HUB-SEC" {
name                 = "sob-snet-sec-hub-01"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes     = ["172.22.0.32/28"]
}

resource "azurerm_subnet" "SNET-HUB-GW" {
name                 = "GatewaySubnet"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes     = ["172.22.0.48/28"]
}

resource "azurerm_subnet" "SNET-HUB-FW" {
name                 = "AzureFirewallSubnet"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes     = ["172.22.0.64/26"]
}

*/






resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.vnet1}"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["172.22.1.0/24"]
  dns_servers         = ["172.22.0.4" , "172.22.0.5"]

  subnet {
    name           = "sob-snet-web-spoke1-01"
    address_prefix = "${var.Spoke1subnet[0]}"
  }

  subnet {
    name           = "sob-snet-app-spoke1-01"
    address_prefix = "${var.Spoke1subnet[1]}"
  }

  subnet {
    name           = "sob-snet-db-spoke1-01"
    address_prefix = "${var.Spoke1subnet[2]}"
  }




  tags = {
    "Environment" = "Production"
    "Resource" = "VNET"
    "Cost Center" = "YTV"
    "Location" = "South India"
  }
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "${var.vnet2}"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["172.22.2.0/24"]
  dns_servers         = ["172.22.0.4" , "172.22.0.5"]

  subnet {
    name           = "sob-snet-web-spoke2-01"
    address_prefix = "${var.Spoke2subnet[0]}"
  }

  subnet {
    name           = "sob-snet-app-spoke2-01"
    address_prefix = "${var.Spoke2subnet[1]}"
  }

  subnet {
    name           = "sob-snet-db-spoke2-01"
    address_prefix = "${var.Spoke2subnet[2]}"
  }




  tags = {
    "Environment" = "Production"
    "Resource" = "VNET"
    "Cost Center" = "YTV"
    "Location" = "South India"
  }
}

resource "azurerm_virtual_network" "vnet3" {
  name                = "${var.vnet3}"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["172.22.3.0/24"]
  dns_servers         = ["172.22.0.4" , "172.22.0.5"]

  subnet {
    name           = "sob-snet-web-spoke3-01"
    address_prefix = "${var.Spoke3subnet[0]}"
  }

  subnet {
    name           = "sob-snet-app-spoke3-01"
    address_prefix = "${var.Spoke3subnet[1]}"
  }

  subnet {
    name           = "sob-snet-db-spoke3-01"
    address_prefix = "${var.Spoke3subnet[2]}"
  }




  tags = {
    "Environment" = "Production"
    "Resource" = "VNET"
    "Cost Center" = "YTV"
    "Location" = "South India"
  }
}


resource "azurerm_virtual_network" "vnet4" {
  name                = "${var.vnet4}"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["172.22.4.0/24"]
  dns_servers         = ["172.22.0.4" , "172.22.0.5"]

  subnet {
    name           = "sob-snet-web-spoke4-01"
    address_prefix = "${var.Spoke4subnet[0]}"
  }

  subnet {
    name           = "sob-snet-app-spoke4-01"
    address_prefix = "${var.Spoke4subnet[1]}"
  }

  subnet {
    name           = "sob-snet-db-spoke4-01"
    address_prefix = "${var.Spoke4subnet[2]}"
  }



  tags = {
    "Environment" = "Production"
    "Resource" = "VNET"
    "Cost Center" = "YTV"
    "Location" = "South India"
  }
}


resource "azurerm_virtual_network" "vnet5" {
  name                = "${var.vnet5}"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["172.22.5.0/24"]
  dns_servers         = ["172.22.0.4" , "172.22.0.5"]

  tags = {
    "Environment" = "Production"
    "Resource" = "VNET"
    "Cost Center" = "YTV"
    "Location" = "South India"
  }
}

resource "azurerm_subnet" "SNET-SPOKE5-WEB" {
name                 = "sob-snet-web-spoke5-01"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet5.name
address_prefixes     = ["${var.Spoke5subnet[0]}"]
depends_on = [
  azurerm_virtual_network.vnet5
]
}

resource "azurerm_network_security_group" "NSG-SPOKE5-WEB" {
name                = "${var.NSG16}"
location            = azurerm_resource_group.RG.location
resource_group_name = azurerm_resource_group.RG.name
depends_on = [
  azurerm_subnet.SNET-SPOKE5-WEB
]  
}

resource "azurerm_subnet_network_security_group_association" "NSG-SPOKE5-WEB-A" {
subnet_id                 = azurerm_subnet.SNET-SPOKE5-WEB.id
network_security_group_id = azurerm_network_security_group.NSG-SPOKE5-WEB.id
depends_on = [
  azurerm_network_security_group.NSG-SPOKE5-WEB
 ]
}

resource "azurerm_subnet" "SNET-SPOKE5-APP" {
name                 = "sob-snet-app-spoke5-01"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet5.name
address_prefixes     = ["${var.Spoke5subnet[1]}"]
depends_on = [
  azurerm_virtual_network.vnet5
]
}

resource "azurerm_network_security_group" "NSG-SPOKE5-APP" {
name                = "${var.NSG17}"
location            = azurerm_resource_group.RG.location
resource_group_name = azurerm_resource_group.RG.name
depends_on = [
  azurerm_subnet.SNET-SPOKE5-APP
]  
}

resource "azurerm_subnet_network_security_group_association" "NSG-SPOKE5-APP-A" {
subnet_id                 = azurerm_subnet.SNET-SPOKE5-APP.id
network_security_group_id = azurerm_network_security_group.NSG-SPOKE5-APP.id
depends_on = [
  azurerm_network_security_group.NSG-SPOKE5-APP
 ]
}


resource "azurerm_subnet" "SNET-SPOKE5-DB" {
name                 = "sob-snet-db-spoke5-01"
resource_group_name  = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet5.name
address_prefixes     = ["${var.Spoke5subnet[2]}"]
depends_on = [
  azurerm_virtual_network.vnet5
]
}

resource "azurerm_network_security_group" "NSG-SPOKE5-DB" {
name                = "${var.NSG18}"
location            = azurerm_resource_group.RG.location
resource_group_name = azurerm_resource_group.RG.name
depends_on = [
  azurerm_subnet.SNET-SPOKE5-DB
]  
}

resource "azurerm_subnet_network_security_group_association" "NSG-SPOKE5-DB-A" {
subnet_id                 = azurerm_subnet.SNET-SPOKE5-DB.id
network_security_group_id = azurerm_network_security_group.NSG-SPOKE5-DB.id
depends_on = [
  azurerm_network_security_group.NSG-SPOKE5-DB
 ]
}














