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

variable "rg_location" {
  description = "test resoruce group"
}

variable "rg_purpose" {
  description = "purpose of resoruce group"
  default = "tf-demo"
}

resource "azurerm_resource_group" "tfrg" {
  name     = var.rg_location
  location = "West Europe"

  tags = {
    "owner"   = "Ravikanth C"
    "purpose" = var.rg_purpose
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

output "static-web-url" {
  value = data.azurerm_storage_account.test.primary_web_endpoint
}