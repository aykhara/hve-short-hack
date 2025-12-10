output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.main.location
}

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.networking.vnet_id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = module.networking.vnet_name
}

output "app_service_name" {
  description = "Name of the App Service"
  value       = module.compute.app_service_name
}

output "app_service_default_hostname" {
  description = "Default hostname of the App Service"
  value       = module.compute.app_service_default_hostname
}

output "api_endpoint" {
  description = "Public URL endpoint for the API via Application Gateway"
  value       = module.compute.api_endpoint
}

output "gateway_public_ip" {
  description = "Public IP address of the Application Gateway"
  value       = module.compute.gateway_public_ip
}

output "database_name" {
  description = "Name of the PostgreSQL server"
  value       = module.database.database_name
}

output "database_fqdn" {
  description = "FQDN of the PostgreSQL server"
  value       = module.database.database_fqdn
  sensitive   = true
}

output "database_endpoint" {
  description = "Connection endpoint for the database"
  value       = module.database.database_endpoint
  sensitive   = true
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = module.monitoring.log_analytics_workspace_name
}

output "storage_account_name" {
  description = "Name of the storage account for logs and backups"
  value       = module.monitoring.storage_account_name
}

