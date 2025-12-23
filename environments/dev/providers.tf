terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }

  cloud {
    organization = "three-tire-proj"
    workspaces {
      name = "core_module_three_tire"
    }
   }
  }

# backend "azurerm" {
#     resource_group_name  = "dev-rg"
#     storage_account_name = "statefilestorage2212"
#     container_name       = "statefilecontainer"
#     key                  = "terraform.tfstate"
#   }
# }

provider "azurerm" {

  features { 
    #  resource_group {
    #     prevent_deletion_if_contains_resources = false
    #   }
    }
 }