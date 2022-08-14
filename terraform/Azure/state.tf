terraform {
  backend "azurerm" {
    resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "stor12"
    container_name       = "tfstate"
    key                  = "test-terraform"
  }
}
