terraform {
  required_version = ">= 1.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.68.0, <4.0"
    }
  }
}
