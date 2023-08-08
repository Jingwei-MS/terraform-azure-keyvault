resource "random_string" "suffix" {
  length = 6
  upper = false
  special = false
}

#create a resource group
resource "azurerm_resource_group" "rg"{
  location = "eastus"
  name     = "keyvaultgroup-${random_string.suffix.result}"
}

data "azurerm_client_config" "this" {}

module "echo" {
  source = "../.."
  key_vault_location = azurerm_resource_group.rg.location
  key_vault_name = "keyvault-${random_string.suffix.result}"
  key_vault_resource_group_name = azurerm_resource_group.rg.name
  key_vault_sku_name = "standard"
  key_vault_tenant_id = data.azurerm_client_config.this.tenant_id
}



