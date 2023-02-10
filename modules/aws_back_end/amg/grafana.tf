module "managed_grafana" {
  source = "terraform-aws-modules/managed-service-grafana/aws"

  # Workspace
  name                      = "example"
  description               = "AWS Managed Grafana service example workspace"
  account_access_type       = "CURRENT_ACCOUNT"
  authentication_providers  = ["AWS_SSO"]
  permission_type           = "SERVICE_MANAGED"
  data_sources              = ["CLOUDWATCH", "PROMETHEUS", "XRAY"]
  notification_destinations = ["SNS"]

  # Workspace API keys
  workspace_api_keys = {
    viewer = {
      key_name        = "viewer"
      key_role        = "VIEWER"
      seconds_to_live = 3600
    }
    editor = {
      key_name        = "editor"
      key_role        = "EDITOR"
      seconds_to_live = 3600
    }
    admin = {
      key_name        = "admin"
      key_role        = "ADMIN"
      seconds_to_live = 3600
    }
  }
  associate_license = false
#   # Workspace SAML configuration
#   saml_admin_role_values  = ["admin"]
#   saml_editor_role_values = ["editor"]
#   saml_email_assertion    = "mail"
#   saml_groups_assertion   = "groups"
#   saml_login_assertion    = "mail"
#   saml_name_assertion     = "displayName"
#   saml_org_assertion      = "org"
#   saml_role_assertion     = "role"
#   saml_idp_metadata_url   = "https://my_idp_metadata.url"

  # Role associations
  role_associations = {
    "ADMIN" = {
      "user_ids" = ["69fe0448-50d1-70ed-46cc-c1eb2cd9e359"]
    }
  }

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
}