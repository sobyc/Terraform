output "rgid" {
  value = module.Resource_Group.rgid
}

output "vnetprodid" {
  value = module.vnet.vnetid
}

output "vnetcidr" {
  value = module.vnet.vnetcidr
}

output "snet1id" {
  value = module.snet1.snetid
}

output "snet2id" {
  value = module.snet2.snetid
}

output "snet3id" {
  value = module.snet3.snetid
}

output "snet1cidr" {
  value = module.snet1.snetcidr
}

output "nsgid" {
  value = module.nsgsnet1.nsg-id
}

