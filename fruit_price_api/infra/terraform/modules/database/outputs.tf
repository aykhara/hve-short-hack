output "database_id" {
  description = "ID of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.main.id
}

output "database_name" {
  description = "Name of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.main.name
}

output "database_fqdn" {
  description = "FQDN of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "database_endpoint" {
  description = "Connection endpoint for the database"
  value       = "${azurerm_postgresql_flexible_server.main.fqdn}:5432"
}

output "database_db_name" {
  description = "Name of the database"
  value       = azurerm_postgresql_flexible_server_database.main.name
}
