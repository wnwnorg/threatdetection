
terraform {
  required_providers {
    sysdig = {
      source  = "sysdiglabs/sysdig"
    }
  }
}
provider "sysdig" {
  sysdig_secure_url       = "https://us2.app.sysdig.com"
  sysdig_secure_api_token = "8b1d6715-acee-453c-92d9-86bb07b2a77d"
}
provider "azurerm" {
  features { }
  subscription_id = "500eff07-7365-421e-864c-bb36d307e37c"
}
module "secure_for_cloud_example_single_subscription" {
  source = "sysdiglabs/secure-for-cloud/azurerm//examples/single-subscription"
  name = "sdsr"
}