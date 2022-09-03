terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate27177"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
