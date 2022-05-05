output "bastionhost_name" {
  value       = azurerm_bastion_host.bastion.name
  description = "Name of bastion host"
}

output "bastionhost_subnet" {
  value       = azurerm_subnet.subnet.name
  description = "Name of bastion host subnet"
}

output "bastionhost_subnetid" {
  value       = azurerm_subnet.subnet.id
  description = "Bastion host subnet ID"
}

output "bastionhost_ip" {
  value       = azurerm_public_ip.pubip.ip_address
  description = "Bastion Host Ip address"
}