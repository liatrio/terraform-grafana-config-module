
variable "aws_region" {
  description = "Contains the AWS Region that Grafana is running in."
  type        = string
  default     = "us-east-1"
}

variable "data_source_map" {
  description = "A list of maps representing datasource information. Each map defines a data source with its type, name, and url."
  type        = list(map(string))
  default = [
    { "data_source_type" = "cloudwatch"
      "data_source_name" = "CloudName1"
    "data_source_url" = "https://cloudwatch.amazonaws.com" },
    { "data_source_type" = "prometheus"
      "data_source_name" = "PromName1"
    "data_source_url" = "https://prometheus.amazonaws.com" },
    { "data_source_type" = "prometheus"
      "data_source_name" = "PromName2"
    "data_source_url" = "https://prometheus2.amazonaws.com" }
  ]
}

variable "dashboard_configs_folder" {
  description = "The path to the dashboards folder where the configuration files are located."
  type        = string
}

variable "grafana_url" {
  description = "The url to your Grafana instance."
  type        = string
}

variable "alarm_rules" {
  description = "The contents of the alarm rules file."
  type        = string
}

variable "prometheus_workspace_id" {
  description = "The workspace ID of the prometheus instance you wish to modify."
  type        = string
}

variable "grafana_workspace_id" {
  description = "The workspace ID of the grafana instance you wish to modify."
  type        = string
}