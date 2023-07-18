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
data "terraform_remote_state" "grafana_module" {
  backend = "s3"
  config = {
    bucket = "observability-us-east-1-dev-tf-state-test"
    key    = "nonprod/aws-managed-services/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "grafana" {
  url  = local.grafana_url
  auth = data.terraform_remote_state.grafana_module.workspace_api_keys["admin"].key
}

resource "grafana_folder" "this" {
  org_id = local.org_id
  title  = "adrielp"
}

resource "grafana_dashboard" "this" {
  org_id = local.org_id
  folder = "adrielp"
  url    = "https://grafana.com/api/dashboards/6098/revisions/1/download"
}