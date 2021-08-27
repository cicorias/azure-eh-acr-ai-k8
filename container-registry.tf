resource "azurerm_container_registry" "acr" {
  name                = local.settings.container_registry_name // Name of the resource defined in the settings file. 
  location            = azurerm_resource_group.rg.location // Use resource group location.
  resource_group_name = azurerm_resource_group.rg.name // Use our resource group from the current workspace.
  sku                 = "Basic" // We will use the not so expensive one for this demo.
  admin_enabled       = false
}