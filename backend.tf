terraform {
  backend "azurerm" {
    resource_group_name  = "test1-rg"
    storage_account_name = "terraformazureak"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }
}
