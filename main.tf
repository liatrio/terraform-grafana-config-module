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
  depends_on = [grafana_folder.this]

  org_id = local.org_id
  folder = grafana_folder.this.id
  config_json = file("test2.json")
}