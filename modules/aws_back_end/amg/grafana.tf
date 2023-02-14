module "managed_grafana" {
  source = "terraform-aws-modules/managed-service-grafana/aws"

  # Workspace
  name                      = "${var.prefix}--${terraform.workspace}-grafana"
  description               = "AWS Managed Grafana service-${var.prefix}--${terraform.workspace} workspace"
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

  # Role associations
  role_associations = {
    "ADMIN" = {
      "user_ids" = ["69fe0448-50d1-70ed-46cc-c1eb2cd9e359"]
      // create/get user_id from IAM Identity Center
    }
  }

}