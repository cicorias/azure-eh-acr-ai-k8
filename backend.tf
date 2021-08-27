terraform {
  backend "azurerm" {
    tenant_id            = "0dd608f6-0108-44d4-a52f-ccddc306b592"
    subscription_id      = "39f0f54d-f6e9-44e1-9b3c-2c82dd355541"
    resource_group_name  = "notifier-resource-group"
    storage_account_name = "notifiertfstore"
    container_name       = "notifiertfstate"
    key                  = "terraform-notifier.tfstate"
  }
}