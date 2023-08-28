terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.7.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "2.1.0"
    }
  }
}