resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.project_name}-law-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

resource "azurerm_storage_account" "logs" {
  name                     = "${var.project_name}logs${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 7
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "logs" {
  name                  = "application-logs"
  storage_account_name  = azurerm_storage_account.logs.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "backups" {
  name                  = "database-backups"
  storage_account_name  = azurerm_storage_account.logs.name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "logs" {
  storage_account_id = azurerm_storage_account.logs.id

  rule {
    name    = "delete-old-logs"
    enabled = true

    filters {
      blob_types   = ["blockBlob"]
      prefix_match = ["application-logs/"]
    }

    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = 90
      }
    }
  }

  rule {
    name    = "tier-old-backups"
    enabled = true

    filters {
      blob_types   = ["blockBlob"]
      prefix_match = ["database-backups/"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 30
        tier_to_archive_after_days_since_modification_greater_than = 90
        delete_after_days_since_modification_greater_than          = 365
      }
    }
  }
}

resource "azurerm_monitor_action_group" "main" {
  count               = var.action_group_email != "" ? 1 : 0
  name                = "${var.project_name}-alerts-${var.environment}"
  resource_group_name = var.resource_group_name
  short_name          = "apialerts"

  email_receiver {
    name          = "admin-email"
    email_address = var.action_group_email
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "app_cpu" {
  name                = "${var.project_name}-cpu-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.app_service_id]
  description         = "Alert when CPU usage exceeds 80%"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "CpuPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  dynamic "action" {
    for_each = var.action_group_email != "" ? [1] : []
    content {
      action_group_id = azurerm_monitor_action_group.main[0].id
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "app_response_time" {
  name                = "${var.project_name}-response-time-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.app_service_id]
  description         = "Alert when response time exceeds 2 seconds"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 2
  }

  dynamic "action" {
    for_each = var.action_group_email != "" ? [1] : []
    content {
      action_group_id = azurerm_monitor_action_group.main[0].id
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "app_http_errors" {
  name                = "${var.project_name}-http-errors-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.app_service_id]
  description         = "Alert when HTTP 5xx errors exceed threshold"
  severity            = 1
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 10
  }

  dynamic "action" {
    for_each = var.action_group_email != "" ? [1] : []
    content {
      action_group_id = azurerm_monitor_action_group.main[0].id
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "db_cpu" {
  name                = "${var.project_name}-db-cpu-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.database_id]
  description         = "Alert when database CPU usage exceeds 80%"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name      = "cpu_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  dynamic "action" {
    for_each = var.action_group_email != "" ? [1] : []
    content {
      action_group_id = azurerm_monitor_action_group.main[0].id
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "db_connections" {
  name                = "${var.project_name}-db-connections-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.database_id]
  description         = "Alert when active database connections exceed 80% of max"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
    metric_name      = "active_connections"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  dynamic "action" {
    for_each = var.action_group_email != "" ? [1] : []
    content {
      action_group_id = azurerm_monitor_action_group.main[0].id
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "gateway_unhealthy" {
  name                = "${var.project_name}-gateway-unhealthy-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_gateway_id]
  description         = "Alert when Application Gateway has unhealthy backend instances"
  severity            = 1
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "UnhealthyHostCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0
  }

  dynamic "action" {
    for_each = var.action_group_email != "" ? [1] : []
    content {
      action_group_id = azurerm_monitor_action_group.main[0].id
    }
  }

  tags = var.tags
}
