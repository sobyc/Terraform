

resource "azurerm_resource_group" "rgnet" {
  name     = var.rgname
  location = var.location

}

output "rgid" {
  value = azurerm_resource_group.rgnet.id
}


/*

module "resource-group" {
  source  = "../Modules/Resource_Group.resource-group"
  resource_groups = var.resource_groups
  global_tags     = var.global_tags
}

*/
