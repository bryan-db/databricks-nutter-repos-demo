terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.2.1"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 0.5.9"
    }
    azurerm = {
      version = "~> 2.33"
    }
    random  = {
      version = "~> 2.2"
    }
  }
}

# https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs
provider "azurerm" {
  subscription_id = var.az_subscription_id
  features {}
}

provider "azuredevops" {
  org_service_url       = var.devops_org_url
  personal_access_token = var.devops_pat
}

provider "databricks" {
  host = azurerm_databricks_workspace.this.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.this.id

  auth_type = "azure-cli"
}
