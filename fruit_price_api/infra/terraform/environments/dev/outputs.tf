# Resource Group Outputs
output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.main.location
}

# Networking Outputs
output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

# Container Outputs
output "container_fqdn" {
  description = "Fully qualified domain name of the container (if public)"
  value       = module.container.container_fqdn
}

output "container_ip_address" {
  description = "IP address of the container instance"
  value       = module.container.container_ip_address
}

output "acr_login_server" {
  description = "Azure Container Registry login server URL"
  value       = module.container.acr_login_server
}

output "api_url" {
  description = "URL to access the Fruit Price API"
  value       = module.container.container_fqdn != null ? "http://${module.container.container_fqdn}:${var.container_port}" : "http://${module.container.container_ip_address}:${var.container_port}"
}

# Monitoring Outputs
output "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key"
  value       = module.monitoring.instrumentation_key
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "Application Insights connection string"
  value       = module.monitoring.connection_string
  sensitive   = true
}

output "application_insights_app_id" {
  description = "Application Insights application ID"
  value       = module.monitoring.app_id
}

# Deployment Information
output "deployment_info" {
  description = "Summary of deployed resources"
  value = {
    environment         = var.environment
    location           = var.location
    resource_group     = azurerm_resource_group.main.name
    container_registry = module.container.acr_login_server
    api_endpoint       = module.container.container_fqdn != null ? "http://${module.container.container_fqdn}:${var.container_port}" : "http://${module.container.container_ip_address}:${var.container_port}"
  }
}
