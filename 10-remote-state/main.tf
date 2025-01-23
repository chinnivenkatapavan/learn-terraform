terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup-1"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "d82tfstate"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstates"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "example.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

output"test" {
    test = "hello"
    }