# Log Analytics Workspace (required for Application Insights)
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.app_name}-${var.environment}-law"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_days

  tags = merge(
    var.tags,
    {
      environment = var.environment
      component   = "log-analytics"
    }
  )
}

# Application Insights
resource "azurerm_application_insights" "appinsights" {
  name                = "${var.app_name}-${var.environment}-ai"
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = var.application_type
  workspace_id        = azurerm_log_analytics_workspace.law.id
  retention_in_days   = var.retention_days

  tags = merge(
    var.tags,
    {
      environment = var.environment
      component   = "application-insights"
    }
  )
}
