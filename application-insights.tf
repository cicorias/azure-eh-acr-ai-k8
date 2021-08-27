resource "azurerm_application_insights" "ai" {
  name                = local.settings.application_insights_name // Name of the resource defined in the settings file. 
  location            = azurerm_resource_group.rg.location // Use resource group location.
  resource_group_name = azurerm_resource_group.rg.name // Use our resource group from the current workspace.
  application_type    = "other" // The type of application. We use "other" here, so it is not so specific like "web", "java", etc.
  retention_in_days   = 90 // The default retention used here.
  sampling_percentage = 100 // To get the most accurate results without so many loose of data.
}
