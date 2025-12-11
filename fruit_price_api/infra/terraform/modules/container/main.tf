# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = replace("${var.app_name}${var.environment}acr", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = merge(
    var.tags,
    {
      environment = var.environment
      component   = "container-registry"
    }
  )
}

# Azure Container Instance
resource "azurerm_container_group" "aci" {
  name                = "${var.app_name}-${var.environment}-aci"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  ip_address_type     = var.subnet_id != null ? "Private" : "Public"
  dns_name_label      = var.subnet_id == null ? "${var.app_name}-${var.environment}" : null
  subnet_ids          = var.subnet_id != null ? [var.subnet_id] : null

  container {
    name   = var.app_name
    image  = "${azurerm_container_registry.acr.login_server}/${var.container_image}"
    cpu    = var.cpu_cores
    memory = var.memory_gb

    ports {
      port     = var.container_port
      protocol = "TCP"
    }

    environment_variables = {
      FLASK_APP = "src.app:create_app"
      FLASK_ENV = var.environment
    }
  }

  image_registry_credential {
    server   = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
  }

  tags = merge(
    var.tags,
    {
      environment = var.environment
      component   = "container-instance"
    }
  )

  depends_on = [azurerm_container_registry.acr]
}
