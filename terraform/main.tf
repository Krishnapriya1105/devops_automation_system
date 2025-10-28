terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "devops_rg" {
  name     = "devops-resource-group"
  location = "eastus"
}

# Azure Container Registry (ACR)
resource "azurerm_container_registry" "devops_acr" {
  name = "duraiacr98765"  # must be globally unique
  resource_group_name = azurerm_resource_group.devops_rg.name
  location            = azurerm_resource_group.devops_rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "devops_aks" {
  name                = "devops-aks-cluster"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
  dns_prefix          = "devopsaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "acr_login_server" {
  value = azurerm_container_registry.devops_acr.login_server
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.devops_aks.name
}
