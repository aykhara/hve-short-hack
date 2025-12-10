variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "fruitpriceapi"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "FruitPriceAPI"
  }
}

# Networking variables
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "app_subnet_address_prefix" {
  description = "Address prefix for app service subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "db_subnet_address_prefix" {
  description = "Address prefix for database subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "gateway_subnet_address_prefix" {
  description = "Address prefix for application gateway subnet"
  type        = string
  default     = "10.0.3.0/24"
}

# Compute variables
variable "app_service_sku_name" {
  description = "SKU name for App Service Plan"
  type        = string
  default     = "B1"
}

variable "min_instances" {
  description = "Minimum number of instances for auto-scaling"
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of instances for auto-scaling"
  type        = number
  default     = 3
}

# Database variables
variable "db_sku_name" {
  description = "SKU name for PostgreSQL"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "db_storage_mb" {
  description = "Storage size in MB for PostgreSQL"
  type        = number
  default     = 32768
}

variable "db_backup_retention_days" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "db_geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups"
  type        = bool
  default     = false
}

variable "db_administrator_login" {
  description = "Administrator login for PostgreSQL"
  type        = string
  default     = "dbadmin"
}

variable "db_administrator_password" {
  description = "Administrator password for PostgreSQL"
  type        = string
  sensitive   = true
}

# Monitoring variables
variable "action_group_email" {
  description = "Email address for alert notifications"
  type        = string
  default     = ""
}

