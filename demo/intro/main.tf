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
  #client_id = "value"
  #client_secret = "value"
  #client_certificate_password = "value"
  #client_certificate_path = "value"
  #msi_endpoint = "value"
  #use_msi = false
}

resource "azurerm_resource_group" "tfrg1" {
  name     = "tfrg"
  location = "West Europe"

  tags = {
    "owner"   = "Ravikanth C"
    "purpose" = "tf-demo"
  }
}

resource "azurerm_resource_group" "tfrg2" {
  name     = "tfrg2"
  location = "West Europe"

  tags = {
    "owner" = "Ravikanth C"
  }
}