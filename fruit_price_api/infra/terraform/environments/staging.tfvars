environment             = "staging"
location                = "eastus"
project_name            = "fruitpriceapi"
resource_group_name     = ""

# Networking
vnet_address_space           = ["10.1.0.0/16"]
app_subnet_address_prefix    = "10.1.1.0/24"
db_subnet_address_prefix     = "10.1.2.0/24"
gateway_subnet_address_prefix = "10.1.3.0/24"

# Compute
app_service_sku_name = "S1"
min_instances        = 2
max_instances        = 4

# Database
db_sku_name                    = "GP_Standard_D2s_v3"
db_storage_mb                  = 65536
db_backup_retention_days       = 14
db_geo_redundant_backup_enabled = false
db_administrator_login         = "dbadmin"
db_administrator_password      = "P@ssw0rd123!"  # Change this in production!

# Monitoring
action_group_email = ""  # Optional: Add email for alerts

# Tags
common_tags = {
  Environment = "Staging"
  ManagedBy   = "Terraform"
  Project     = "FruitPriceAPI"
  CostCenter  = "Engineering"
}
