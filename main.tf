terraform {
  required_version = ">=1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.1, < 6.0"
    }
  }
}

provider "google"{
  project="release-book"
}

module "agentless_workload" {
  source = "git::https://github.com/sysdiglabs/terraform-google-secure.git//modules/services/workload-scan"

  #version = "v0.1.15" 

  project_id    = "release-book"
  sysdig_backend ="263844535661"
  # sysdig_account_id ="GCP_SERVICE_ACCOUNT_ID"
}

output "onboarding_agentless_workload" {
  value = module.agentless_workload
}
