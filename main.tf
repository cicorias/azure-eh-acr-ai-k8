provider "azurerm" {
  version = "= 2.33.0"
  features {
  }
  skip_provider_registration = "true"
}

provider "helm" {
  version = "= 2.0.2"
  kubernetes {
    host                    = azurerm_kubernetes_cluster.aks.kube_config.0.host
    client_key              = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
    client_certificate      = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
    cluster_ca_certificate  = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  }
}

# Here we define settings which will be used when creating the resources.
locals {
  default_tfsettings = {

  }

  commonSettingsFile = "./settings/common.yaml"
  commonSettingsFileContent = fileexists(local.commonSettingsFile) ? file(local.commonSettingsFile) : "NoTFCommonSettingsFileFound: true"
  commonSettings = yamldecode(local.commonSettingsFileContent)

  workspaceSettingsFile = "./settings/${terraform.workspace}.yaml"
  workspaceSettingsFileContent = fileexists(local.workspaceSettingsFile) ? file(local.workspaceSettingsFile) : "NoTFWorkspaceSettingsFileFound: true"
  workspaceSettings = yamldecode(local.workspaceSettingsFileContent)

  settings = merge(local.default_tfsettings, local.commonSettings, local.workspaceSettings)
}

# Defines our first resource - the resource group in which we create other resources.
resource "azurerm_resource_group" "rg" {
  name     = local.settings.resource_group_name
 // The resource group name in azure.
  location = "West Europe"
}
