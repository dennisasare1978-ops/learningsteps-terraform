# Random suffix to ensure unique DB name every time
resource "random_string" "db_suffix" {
  length  = 6
  upper   = false
  special = false
}

# PostgreSQL Flexible Server (PRIVATE ONLY)
resource "azurerm_postgresql_flexible_server" "main" {
  name                   = "psql-${var.prefix}-${random_string.db_suffix.result}"
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name

  version                = "15"
  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password

  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768

  # 🔐 Disable public access
  public_network_access_enabled = false

  # Prevent Terraform zone errors
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [zone]
  }
}

# Application Database
resource "azurerm_postgresql_flexible_server_database" "app" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.main.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

# 🔐 Private DNS Zone
resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.main.name
}

# 🔐 Link DNS zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "dns-link-postgres"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = azurerm_virtual_network.main.id
}

# 🔐 Private Endpoint (Correct + Complete)
resource "azurerm_private_endpoint" "postgres" {
  name                = "pe-postgres-${var.prefix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = azurerm_subnet.app.id

  private_service_connection {
    name                           = "psc-postgres"
    private_connection_resource_id = azurerm_postgresql_flexible_server.main.id
    is_manual_connection           = false
    subresource_names              = ["postgresqlServer"]
  }

  # ✅ Correct DNS attachment (INSIDE endpoint)
  private_dns_zone_group {
    name = "postgres-dns-zone-group"

    private_dns_zone_ids = [
      azurerm_private_dns_zone.postgres.id
    ]
  }
}
