variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "app_name" {
  description = "Application name used for resource naming"
  type        = string
  default     = "fruit-price-api"
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.app_name))
    error_message = "App name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "container_image" {
  description = "Container image name and tag"
  type        = string
  default     = "fruit-price-api:latest"
}

variable "container_port" {
  description = "Port the container application listens on"
  type        = number
  default     = 5000
  
  validation {
    condition     = var.container_port > 0 && var.container_port <= 65535
    error_message = "Container port must be between 1 and 65535."
  }
}

variable "cpu_cores" {
  description = "Number of CPU cores allocated to the container"
  type        = number
  default     = 1
  
  validation {
    condition     = var.cpu_cores >= 0.5 && var.cpu_cores <= 4
    error_message = "CPU cores must be between 0.5 and 4."
  }
}

variable "memory_gb" {
  description = "Memory in GB allocated to the container"
  type        = number
  default     = 1.5
  
  validation {
    condition     = var.memory_gb >= 0.5 && var.memory_gb <= 16
    error_message = "Memory must be between 0.5 and 16 GB."
  }
}

variable "log_retention_days" {
  description = "Number of days to retain logs in Application Insights"
  type        = number
  default     = 30
  
  validation {
    condition     = contains([30, 60, 90, 120, 180, 270, 365, 550, 730], var.log_retention_days)
    error_message = "Log retention must be one of: 30, 60, 90, 120, 180, 270, 365, 550, or 730 days."
  }
}
