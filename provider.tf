# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "85c7908d-8028-4894-af5d-1991ee8f0450"
  client_id       = "1b2e5a8a-abe1-415a-9d23-4b868f9d2482"
  client_secret   = "QWh8Q~L0WncaC6bZSjqElbc-hlNSZGuDKPFvbcc5"
  tenant_id       = "37bb0008-2586-4514-a753-d1092d7259f2"
}
