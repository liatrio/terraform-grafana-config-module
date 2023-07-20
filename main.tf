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
    
    # Creates a set containing all the files and subfolder paths in the "./dashboards" directory.
    subfolders_and_files_set = fileset("./dashboards", "**")
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

data "aws_secretsmanager_secret_version" "amg_token" {
  secret_id = "AMG_API_Token"
}

provider "grafana" {
  url  = local.grafana_url
  auth = data.aws_secretsmanager_secret_version.amg_token.secret_string
}

resource "grafana_folder" "dashboard_folders" {
  for_each = toset(local.subfolder_names)
  
  org_id = local.org_id
  title  = each.key
}

resource "grafana_dashboard" "dynamic_dashboard" {
  for_each = { for item in local.flattened_dashboard_data : item.file_path => item }

  overwrite = true
  folder  = local.grafana_folder_map[each.value["folder_name"]].id
  config_json = file("${path.module}/dashboards/${each.key}")
}