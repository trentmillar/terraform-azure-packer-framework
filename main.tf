terraform {
  required_providers {
    azurerm = "~> 3.0"
  }
}

provider "azurerm" {
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  features {}
}
