data "azurerm_resource_group" "example" {
  name = "project-setup-1"
}

output "rg" {
    value = data.azurerm_resource_group.example
    }

provider "azurerm" {
    features {}
    subscription_id = "b3406e49-0e16-456d-a3bb-c324f1dfb0d5"

    }