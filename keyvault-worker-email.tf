# Key vault definition
resource "azurerm_key_vault" "kv_worker_email" {
  name                        = local.settings.keyvault_worker_email_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = false
  enabled_for_template_deployment = true
  tenant_id                   = local.settings.tenant_id
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
}

# Access policy
resource "azurerm_key_vault_access_policy" "ap_worker_email_admin" {
  for_each     = local.settings.kv_allow
  key_vault_id = azurerm_key_vault.kv_worker_email.id

  tenant_id = local.settings.tenant_id
  object_id = each.value.object_id

  secret_permissions = each.value.secret_permissions
}

# Key vault entries
resource "azurerm_key_vault_secret" "kvs_worker_email_appinsights" {
  name         = "ApplicationInsights--InstrumentationKey"
  value        = azurerm_application_insights.ai.instrumentation_key
  key_vault_id = azurerm_key_vault.kv_worker_email.id
  depends_on = [azurerm_key_vault_access_policy.ap_worker_email_admin]
}

resource "azurerm_key_vault_secret" "kvs_worker_email_eventhub" {
  name         = "EventHubSettings--ConnectionString"
  value        = azurerm_eventhub_authorization_rule.notifications_notifier_listen.primary_connection_string
  key_vault_id = azurerm_key_vault.kv_worker_email.id
  depends_on = [azurerm_key_vault_access_policy.ap_worker_email_admin]
}