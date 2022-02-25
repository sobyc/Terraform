/*

provider "azurerm" {
  version         = "=1.16.0"
  tenant_id       = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
  subscription_id = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
  client_id       = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
  client_secret   = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
  alias           = "dev"
}

provider "azurerm" {
  version         = "=1.16.0"
  tenant_id       = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
  subscription_id = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
  client_id       = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
  client_secret   = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
  alias           = "test"
}

data "azurerm_virtual_network" "dev" {
  name                = "dev-network"
  resource_group_name = "dev-network-rg"
  provider            = "azurerm.dev"
}

data "azurerm_virtual_network" "test" {
  name                = "test-network"
  resource_group_name = "test-network-rg"
  provider            = "azurerm.test"
}

resource "azurerm_virtual_network_peering" "dev-to-test" {
  name                         = "dev-to-test"
  resource_group_name          = "${data.azurerm_virtual_network.test.resource_group_name}"
  virtual_network_name         = "${data.azurerm_virtual_network.test.name}"
  remote_virtual_network_id    = "${data.azurerm_virtual_network.test.id}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  provider                     = "azurerm.dev"
}

resource "azurerm_virtual_network_peering" "test-to-dev" {
  name                         = "test-to-dev"
  resource_group_name          = "${data.azurerm_virtual_network.dev.resource_group_name}"
  virtual_network_name         = "${data.azurerm_virtual_network.dev.name}"
  remote_virtual_network_id    = "${data.azurerm_virtual_network.dev.id}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  provider                     = "azurerm.test"
}

*/

# =========================================================================
/* Code having Sopke in Different Subscription
# Create separate Service Principle in both the subscription and provide contributor access to both service principle to 
    othe service principle in other subscription and vice versa , in order for this code to work

provider "azurerm" {
alias = "sub1"
subscription_id = "${var.subscription1_id}"
tenant_id = "${var.tenant_id}"
client_id = "${var.client_id}"
client_secret = "${var.client_secret}"
}

provider "azurerm" {
alias = "sub2"
subscription_id = "${var.subscription2_id}"
tenant_id = "${var.tenant_id}"
client_id = "${var.client_id}"
client_secret = "${var.client_secret}"
}

data "azurerm_resource_group" "rg1" {
provider = "azurerm.sub1"
name = "${var.resource_group_name1}"
}

data "azurerm_resource_group" "rg2" {
provider = "azurerm.sub2"
name = "${var.resource_group_name2}"
}

data "azurerm_virtual_network" "vnet1" {
provider = "azurerm.sub1"
name = "${var.virtual_network_name1}"
resource_group_name = "${data.azurerm_resource_group.rg1.name}"
}

data "azurerm_virtual_network" "vnet2" {
provider = "azurerm.sub2"
name = "${var.virtual_network_name2}"
resource_group_name = "${data.azurerm_resource_group.rg2.name}"
}

resource "azurerm_virtual_network_peering" "vnet-peer-1" {
provider = "azurerm.sub1"
name = "vnet1-vnet2"
resource_group_name = "${data.azurerm_resource_group.rg1.name}"
virtual_network_name = "${data.azurerm_virtual_network.vnet1.name}"
remote_virtual_network_id = "${data.azurerm_virtual_network.vnet2.id}"
allow_virtual_network_access = "true"
allow_forwarded_traffic = "true"
}

resource "azurerm_virtual_network_peering" "vnet-peer-2" {
provider = "azurerm.sub2"
name = "vnet2-vnet1"
resource_group_name = "${data.azurerm_resource_group.rg2.name}"
virtual_network_name = "${data.azurerm_virtual_network.vnet2.name}"
remote_virtual_network_id = "${data.azurerm_virtual_network.vnet1.id}"
allow_virtual_network_access = "true"
allow_forwarded_traffic = "true"
}

*/