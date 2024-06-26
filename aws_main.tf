provider "aws" {
  alias  = "us-east-1"
  region = "us-east-2"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}

module "single-account-cspm" {
  providers = {
    aws = aws.us-east-1
  }
  source           = "draios/secure-for-cloud/aws//modules/services/trust-relationship"
  role_name        = "sysdig-secure-hp0b"
  trusted_identity = "arn:aws:iam::263844535661:role/us-west-2-production-secure-assume-role"
  external_id      = "321c3efd51b3f9545586d7fb00ebdc4e"
}

module "single-account-threat-detection-us-east-1" {
  providers = {
    aws = aws.us-east-1
  }
  source                  = "draios/secure-for-cloud/aws//modules/services/event-bridge"
  target_event_bus_arn    = "arn:aws:events:us-west-2:263844535661:event-bus/us-west-2-production-falco-1"
  trusted_identity        = "arn:aws:iam::263844535661:role/us-west-2-production-secure-assume-role"
  external_id             = "321c3efd51b3f9545586d7fb00ebdc4e"
  name                    = "sysdig-secure-events-wt1u"
  deploy_global_resources = true
}

module "single-account-threat-detection-us-west-2" {
  providers = {
    aws = aws.us-west-2
  }
  source               = "draios/secure-for-cloud/aws//modules/services/event-bridge"
  target_event_bus_arn = "arn:aws:events:us-west-2:263844535661:event-bus/us-west-2-production-falco-1"
  trusted_identity     = "arn:aws:iam::263844535661:role/us-west-2-production-secure-assume-role"
  external_id          = "321c3efd51b3f9545586d7fb00ebdc4e"
  name                 = "sysdig-secure-events-wt1u"
  role_arn             = module.single-account-threat-detection-us-east-1.role_arn
}

