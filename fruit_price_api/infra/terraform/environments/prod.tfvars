environment             = "prod"
location                = "eastus"
project_name            = "fruitpriceapi"
resource_group_name     = ""

# Networking
vnet_address_space           = ["10.2.0.0/16"]
app_subnet_address_prefix    = "10.2.1.0/24"
db_subnet_address_prefix     = "10.2.2.0/24"
gateway_subnet_address_prefix = "10.2.3.0/24"

# Compute
app_service_sku_name = "P1v3"
min_instances        = 3
max_instances        = 10

# Database
db_sku_name                    = "GP_Standard_D4s_v3"
db_storage_mb                  = 131072
db_backup_retention_days       = 30
db_geo_redundant_backup_enabled = true
db_administrator_login         = "dbadmin"
db_administrator_password      = "P@ssw0rd123!"  # Change this in production!

# Monitoring
action_group_email = "alerts@example.com"  # Update with actual email

# Tags
common_tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
  Project     = "FruitPriceAPI"
  CostCenter  = "Engineering"
  Compliance  = "Required"
}
