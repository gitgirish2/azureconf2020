output "static-web-url" {
  value = data.azurerm_storage_account.test.primary_web_endpoint
}