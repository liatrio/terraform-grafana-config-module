terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "2.1.0"
    }
  }
}

locals {
    org_id = 1
    grafana_url = "https://g-631c971d51.grafana-workspace.us-east-1.amazonaws.com"
}

# Fetch the output from "moduleA"
# data "terraform_remote_state" "managed_grafana" {
#   backend = "s3"
#   config = {
#     bucket = "observability-us-east-1-dev-tf-state-test"
#     key    = "nonprod/aws-managed-services/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

#data "aws_secretsmanager_secret" "amg_token" {
#  name = var.grafana_api_token
#}

data "aws_secretsmanager_secret_version" "amg_token" {
  secret_id = "AMG_API_Token"
}


provider "grafana" {
  url  = local.grafana_url
  auth = data.aws_secretsmanager_secret_version.amg_token.secret_string
}

resource "grafana_folder" "this" {
  org_id = local.org_id
  title  = "adrielp"
}

resource "grafana_dashboard" "this" {
  org_id = local.org_id
  folder = "adrielp"
  config_json = jsonencode({
    id            = 12345,
    uid           = "test-ds-dashboard-uid"
    title         = "Production Overview",
    tags          = ["templated"],
    timezone      = "browser",
    schemaVersion = 16,
    version       = 0,
    refresh       = "25s"
  })
}