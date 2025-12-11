terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.app_name}-${var.environment}-rg"
  location = var.location

  tags = {
    environment = var.environment
    project     = var.app_name
    managed_by  = "terraform"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.app_name}-${var.environment}-vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = var.environment
    component   = "networking"
  }
}

# Subnet for Container Instances
resource "azurerm_subnet" "container" {
  name                 = "container-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "container-delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Monitoring Module
module "monitoring" {
  source = "../../modules/monitoring"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  app_name            = var.app_name
  retention_days      = var.log_retention_days

  tags = {
    environment = var.environment
    project     = var.app_name
  }
}

# Container Module
module "container" {
  source = "../../modules/container"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = var.environment
  app_name            = var.app_name
  container_image     = var.container_image
  container_port      = var.container_port
  cpu_cores           = var.cpu_cores
  memory_gb           = var.memory_gb
  subnet_id           = azurerm_subnet.container.id

  tags = {
    environment = var.environment
    project     = var.app_name
  }

  depends_on = [azurerm_subnet.container]
}
