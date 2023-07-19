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
    subfolders_and_files_set = fileset("./dashboards", "**")
    subfolders_and_files = distinct(split(", ", join(", ", split("/", join(", ", local.subfolders_and_files_set)))))
    subfolder_name = [for entry in local.subfolders_and_files : entry if length(regexall("[.]", entry)) == 0]

    folder_map = {
      for folder in toset(local.subfolder_name) : folder => grafana_folder.dashboard_folders[folder]
    }
}

data "aws_secretsmanager_secret_version" "amg_token" {
  secret_id = "AMG_API_Token"
}

provider "grafana" {
  url  = local.grafana_url
  auth = data.aws_secretsmanager_secret_version.amg_token.secret_string
}

resource "grafana_folder" "dashboard_folders" {
  for_each = toset(local.subfolder_name)
  
  org_id = local.org_id
  title  = each.key
}

resource "grafana_dashboard" "prometheus_dashboards" {
  depends_on = [grafana_folder.dashboard_folders]

  for_each    = fileset("${path.module}/dashboards/prometheus", "*.json")

  overwrite = true
  org_id = local.org_id
  folder = local.folder_map["prometheus"].id

  config_json = file("${path.module}/dashboards/prometheus/${each.key}")
}

resource "grafana_dashboard" "cloudwatch_dashboards" {
  depends_on = [grafana_folder.dashboard_folders]

  for_each    = fileset("${path.module}/dashboards/cloudwatch", "*.json")

  overwrite = true
  org_id = local.org_id
  folder = local.folder_map["cloudwatch"].id

  config_json = file("${path.module}/dashboards/cloudwatch/${each.key}")
}