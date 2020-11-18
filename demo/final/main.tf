terraform {
  required_version = ">= 0.13.0, <= 0.13.5"
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "~> 2.33.0"
    }
  }
}

provider "azure" {
  features {}
  environment = "public"
}

resource "azurerm_resource_group" "tfrg" {
  name     = "tfrg"
  location = "West Europe"

  tags = {
    "owner"   = "Ravikanth C"
    "purpose" = "tf-demo3"
  }
}

resource "azurerm_storage_account" "testsa" {
  name                = "rchagantisaname"
  resource_group_name = azurerm_resource_group.tfrg.name
  location            = "westus"

  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"
}

module "staticweb" {
  source               = "StefanSchoof/static-website/azurerm"
  storage_account_name = azurerm_storage_account.testsa.name
}

data "azurerm_storage_account" "test" {
  name                = azurerm_storage_account.testsa.name
  resource_group_name = azurerm_resource_group.tfrg.name

  depends_on = ["module.staticweb"]
}