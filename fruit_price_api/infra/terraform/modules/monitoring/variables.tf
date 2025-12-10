variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "app_service_id" {
  description = "ID of the App Service to monitor"
  type        = string
}

variable "database_id" {
  description = "ID of the database to monitor"
  type        = string
}

variable "application_gateway_id" {
  description = "ID of the Application Gateway to monitor"
  type        = string
}

variable "action_group_email" {
  description = "Email address for alert notifications"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
