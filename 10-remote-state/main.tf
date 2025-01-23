terraform {
  backend "azurerm"
  {
    resource_group_name  = "project-setup-1"
    storage_account_name = "d82tfstate"
    container_name       = "tfstates"
    key                  = "example.tfstate"
  }
}

output "test" {
    value = "hello"
    }