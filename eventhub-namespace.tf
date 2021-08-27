resource "azurerm_eventhub_namespace" "ehns" {
  name                      = local.settings.eventhub_namespace.name
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  sku                       = "Standard"
  capacity                  = local.settings.eventhub_namespace.capacity
  auto_inflate_enabled      = true
  maximum_throughput_units  = local.settings.eventhub_namespace.maximum_throughput_units
  network_rulesets          = [{
    default_action       = "Deny"
    ip_rule              = []
    virtual_network_rule = []      
  }]

  tags = {
    "creator"     = "markus herkommer"
    "environment" = terraform.workspace
  }
}