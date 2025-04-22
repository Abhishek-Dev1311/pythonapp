provider "azurerm" {
  features {}
  subscription_id = "cd895c76-747a-4ae4-88e4-bad2d370bdce"
}
resource "azurerm_resource_group" "rg" {
  name     = "new2"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "example-aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "exampleaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"  # ✅ Change to a supported size in your region
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

