resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.settings.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = local.settings.aks_dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = local.settings.aks_tag_environment
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

resource "helm_release" "ingress" {
    name      = local.settings.ingress_name
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "nginx-ingress-controller"
    set {
        name  = "rbac.create"
        value = "true"
    }
}