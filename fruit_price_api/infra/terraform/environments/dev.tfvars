environment             = "dev"
location                = "eastus"
project_name            = "fruitpriceapi"
resource_group_name     = ""

# Networking
vnet_address_space           = ["10.0.0.0/16"]
app_subnet_address_prefix    = "10.0.1.0/24"
db_subnet_address_prefix     = "10.0.2.0/24"
gateway_subnet_address_prefix = "10.0.3.0/24"

# Compute
app_service_sku_name = "B1"
min_instances        = 1
max_instances        = 2

# Database
db_sku_name                    = "B_Standard_B1ms"
db_storage_mb                  = 32768
db_backup_retention_days       = 7
db_geo_redundant_backup_enabled = false
db_administrator_login         = "dbadmin"
db_administrator_password      = "P@ssw0rd123!"  # Change this in production!

# Monitoring
action_group_email = ""  # Optional: Add email for alerts

# Tags
common_tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
  Project     = "FruitPriceAPI"
  CostCenter  = "Engineering"
}
