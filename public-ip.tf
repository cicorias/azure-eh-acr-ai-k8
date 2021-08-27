resource "azurerm_public_ip" "example" {
  name                = local.settings.public_ip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = {
    Environment = local.settings.aks_tag_environment
  }
}