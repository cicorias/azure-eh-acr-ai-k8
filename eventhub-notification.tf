# Define the eventhub
resource "azurerm_eventhub" "notifications" {
  name                = "notifications"
  namespace_name      = azurerm_eventhub_namespace.ehns.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = local.settings.eventhub.notifications.partition_count
  message_retention   = local.settings.eventhub.notifications.message_retention
}

# Define eventhub consumers
resource "azurerm_eventhub_consumer_group" "notifications_notifier_appinsights" {
  name                = "appinsights"
  namespace_name      = azurerm_eventhub_namespace.ehns.name
  eventhub_name       = azurerm_eventhub.notifications.name
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_eventhub_consumer_group" "notifications_notifier_email" {
  name                = "email"
  namespace_name      = azurerm_eventhub_namespace.ehns.name
  eventhub_name       = azurerm_eventhub.notifications.name
  resource_group_name = azurerm_resource_group.rg.name
}

# Define eventhub authorization rules
resource "azurerm_eventhub_authorization_rule" "notifications_notifier_send" {
  name                = "send"
  namespace_name      = azurerm_eventhub_namespace.ehns.name
  eventhub_name       = azurerm_eventhub.notifications.name
  resource_group_name = azurerm_resource_group.rg.name
  listen              = false
  send                = true
  manage              = false
}

resource "azurerm_eventhub_authorization_rule" "notifications_notifier_listen" {
  name                = "listen"
  namespace_name      = azurerm_eventhub_namespace.ehns.name
  eventhub_name       = azurerm_eventhub.notifications.name
  resource_group_name = azurerm_resource_group.rg.name
  listen              = true
  send                = false
  manage              = false
}