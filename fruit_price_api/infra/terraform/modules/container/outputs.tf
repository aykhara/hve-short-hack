output "acr_login_server" {
  description = "Azure Container Registry login server URL"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "Azure Container Registry admin username"
  value       = azurerm_container_registry.acr.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "Azure Container Registry admin password"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}

output "container_fqdn" {
  description = "Fully qualified domain name of the container"
  value       = azurerm_container_group.aci.fqdn
}

output "container_ip_address" {
  description = "IP address of the container"
  value       = azurerm_container_group.aci.ip_address
}

output "container_id" {
  description = "ID of the container group"
  value       = azurerm_container_group.aci.id
}
