data "azurerm_resource_group" "example" {
  name = "project-setup-1"
}

data "azurerm_subnet" "example" {
  name                 = "default"
  virtual_network_name = "Project-Network"
  resource_group_name  = data.azurerm_resource_group.example.name
}