output "vm_private_ip" {
  description = "Private IP of the API VM"
  value       = azurerm_network_interface.vm.private_ip_address
}

output "postgresql_fqdn" {
  description = "Fully qualified domain name of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}
