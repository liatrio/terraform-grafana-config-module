variable "grafana_asm_key" {
  description = "Contains the Grafana API Token, given to the provider so that it can interact with grafana."
  type        = string
  default     = "AMG_API_Token"
}

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

variable "asm_api_token_name" {
  description = "Name of the ASM that holds the Grafana API Token."
  type        = string
  sensitive   = true
  default     = "amg-api-token"
}