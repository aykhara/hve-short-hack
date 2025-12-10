terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

locals {
  resource_group_name = var.resource_group_name != "" ? var.resource_group_name : "${var.project_name}-rg-${var.environment}"
  
  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
    }
  )
}

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location

  tags = local.tags
}

module "networking" {
  source = "./modules/networking"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  project_name        = var.project_name

  vnet_address_space           = var.vnet_address_space
  app_subnet_address_prefix    = var.app_subnet_address_prefix
  db_subnet_address_prefix     = var.db_subnet_address_prefix
  gateway_subnet_address_prefix = var.gateway_subnet_address_prefix

  tags = local.tags
}

module "database" {
  source = "./modules/database"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  project_name        = var.project_name

  db_subnet_id = module.networking.db_subnet_id

  administrator_login          = var.db_administrator_login
  administrator_password       = var.db_administrator_password
  sku_name                     = var.db_sku_name
  storage_mb                   = var.db_storage_mb
  backup_retention_days        = var.db_backup_retention_days
  geo_redundant_backup_enabled = var.db_geo_redundant_backup_enabled

  tags = local.tags

  depends_on = [module.networking]
}

module "compute" {
  source = "./modules/compute"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  project_name        = var.project_name

  app_subnet_id     = module.networking.app_subnet_id
  gateway_subnet_id = module.networking.gateway_subnet_id

  sku_name      = var.app_service_sku_name
  min_instances = var.min_instances
  max_instances = var.max_instances

  app_settings = {
    "DATABASE_HOST"     = module.database.database_fqdn
    "DATABASE_NAME"     = module.database.database_db_name
    "DATABASE_USER"     = var.db_administrator_login
    "DATABASE_PASSWORD" = var.db_administrator_password
    "DATABASE_PORT"     = "5432"
  }

  tags = local.tags

  depends_on = [module.networking, module.database]
}

module "monitoring" {
  source = "./modules/monitoring"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  project_name        = var.project_name

  app_service_id         = module.compute.app_service_id
  database_id            = module.database.database_id
  application_gateway_id = module.compute.application_gateway_id

  action_group_email = var.action_group_email

  tags = local.tags

  depends_on = [module.compute, module.database]
}
