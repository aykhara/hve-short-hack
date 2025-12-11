output "instrumentation_key" {
  description = "Application Insights instrumentation key"
  value       = azurerm_application_insights.appinsights.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "Application Insights connection string"
  value       = azurerm_application_insights.appinsights.connection_string
  sensitive   = true
}

output "app_id" {
  description = "Application Insights application ID"
  value       = azurerm_application_insights.appinsights.app_id
}

output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = azurerm_log_analytics_workspace.law.id
}
