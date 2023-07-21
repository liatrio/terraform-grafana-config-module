variable "grafana_asm_key" {
  description = "Contains the Grafana API Token, given to the provider so that it can interact with grafana."
  type        = string
  default     = "AMG_API_Token"
}

variable "aws_region" {
    description = "Contains the AWS Region that Grafana is running in."
    type = string
    default = "us-east-1"
}

variable "data_source_map" {
    description = "A list of maps representing datasource information. Each map defines a data source with its type and name."
    type = list(map(string))
    default = [
    {"data_source_type" = "cloudwatch"
    "data_source_name" = "Name1"},
    {"data_source_type" = "prometheus"
    "datasource_name" = "Name2"},
    {"data_source_type" = "prometheus"
    "data_source_name" = "Name3"}
    ]
}

variable "data_source_name" {
    description = "The name of the data source to be created."
    type = string
    default = "default_name"
}

variable "data_source_type" {
    description = "The type of the data source to be created."
    type = string
    default = "prometheus"
}