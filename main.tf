
locals {
  org_id = 1

  # Creates a set containing all the files and subfolder paths in the "./dashboards" directory. 
  subfolders_and_files_set = fileset("${var.dashboard_configs_folder}", "**")
  # Creates a list that contains the names of the subfolders.
  subfolder_names = distinct([for path in local.subfolders_and_files_set : dirname(path)])
  # Creates a dictionary, mapping folder names to their corresponding dashboard folders in Grafana.  
  grafana_folder_map = {
    for folder in toset(local.subfolder_names) : folder => grafana_folder.dashboard_folders[folder]
  }
  # Creates a dictionary, mapping folder names to their corresponding files.
  folder_files_map = {
    for folder in local.subfolder_names :
    folder => [for file in local.subfolders_and_files_set : file if dirname(file) == folder]
  }
  # Creates a list of dictionaries representing flattened dashboard data.
  flattened_dashboard_data = flatten([
    for folder_name, file_paths in local.folder_files_map : [
      for file_path in file_paths : {
        folder_name = folder_name
        file_path   = file_path
      }
    ]
  ])
}

provider "grafana" {
  url  = var.grafana_url
  auth = aws_grafana_workspace_api_key.key.key
}

resource "aws_grafana_workspace_api_key" "key" {
  key_name        = "amg_api_key"
  key_role        = "ADMIN"
  seconds_to_live = 180
  workspace_id    = var.grafana_workspace_id
  lifecycle {
    create_before_destroy = true
  }
}

resource "grafana_folder" "dashboard_folders" {
  for_each = toset(local.subfolder_names)

  org_id = local.org_id
  title  = each.key
}

resource "grafana_dashboard" "dashboard_from_file" {
  for_each = { for item in local.flattened_dashboard_data : item.file_path => item }

  overwrite   = true
  folder      = local.grafana_folder_map[each.value["folder_name"]].id
  config_json = file("${var.dashboard_configs_folder}/${each.key}")
}

resource "grafana_data_source" "data_source_from_map" {
  for_each = { for item in var.data_source_map : item.data_source_name => item }
  type     = each.value["data_source_type"]
  name     = each.value["data_source_name"]
  url      = each.value["data_source_url"]

  # Giving priority to Managed Prometheus datasources
  # TODO: The Key names are wrong in current implementation, should be camelcase and not snake case.
  is_default = false
  json_data_encoded = jsonencode({
    default_region  = var.aws_region
    httpMethod      = "POST"
    sigV4Auth       = true
    sigV4AuthType   = "ec2_iam_role"
    sigV4Region     = var.aws_region
    sigv4_auth      = true
    sigv4_auth_type = "workspace-iam-role"
    sigv4_region    = var.aws_region
    manageAlerts    = false
  })
}

# --------- Prometheus Configs --------- #

resource "aws_prometheus_rule_group_namespace" "alarm_rule" {
  name         = "rules"
  workspace_id = var.prometheus_workspace_id
  data         = var.alarm_rules
}