# terraform-grafana-config-module

## Terraform Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.7.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.7.0 |
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_prometheus_rule_group_namespace.alarm_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/prometheus_rule_group_namespace) | resource |
| [grafana_dashboard.dashboard_from_file](https://registry.terraform.io/providers/grafana/grafana/2.1.0/docs/resources/dashboard) | resource |
| [grafana_data_source.data_source_from_map](https://registry.terraform.io/providers/grafana/grafana/2.1.0/docs/resources/data_source) | resource |
| [grafana_folder.dashboard_folders](https://registry.terraform.io/providers/grafana/grafana/2.1.0/docs/resources/folder) | resource |
| [aws_secretsmanager_secret_version.amg_sa_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.amg_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_rules"></a> [alarm\_rules](#input\_alarm\_rules) | The contents of the alarm rules file. | `string` | n/a | yes |
| <a name="input_asm_api_token_name"></a> [asm\_api\_token\_name](#input\_asm\_api\_token\_name) | Name of the ASM that holds the Grafana API Token. | `string` | n/a | yes |
| <a name="input_asm_sa_token_name"></a> [asm\_sa\_token\_name](#input\_asm\_sa\_token\_name) | Name of the ASM that holds the Grafana Service Account Token. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Contains the AWS Region that Grafana is running in. | `string` | `"us-east-1"` | no |
| <a name="input_dashboard_configs_folder"></a> [dashboard\_configs\_folder](#input\_dashboard\_configs\_folder) | The path to the dashboards folder where the configuration files are located. | `string` | n/a | yes |
| <a name="input_data_source_map"></a> [data\_source\_map](#input\_data\_source\_map) | A list of maps representing datasource information. Each map defines a data source with its type, name, and url. | `list(map(string))` | <pre>[<br>  {<br>    "data_source_name": "CloudName1",<br>    "data_source_type": "cloudwatch",<br>    "data_source_url": "https://cloudwatch.amazonaws.com"<br>  },<br>  {<br>    "data_source_name": "PromName1",<br>    "data_source_type": "prometheus",<br>    "data_source_url": "https://prometheus.amazonaws.com"<br>  },<br>  {<br>    "data_source_name": "PromName2",<br>    "data_source_type": "prometheus",<br>    "data_source_url": "https://prometheus2.amazonaws.com"<br>  }<br>]</pre> | no |
| <a name="input_grafana_asm_key"></a> [grafana\_asm\_key](#input\_grafana\_asm\_key) | Contains the Grafana API Token, given to the provider so that it can interact with grafana. | `string` | `"AMG_API_Token"` | no |
| <a name="input_grafana_url"></a> [grafana\_url](#input\_grafana\_url) | The url to your Grafana instance. | `string` | n/a | yes |
| <a name="input_prometheus_workspace_id"></a> [prometheus\_workspace\_id](#input\_prometheus\_workspace\_id) | The workspace ID of the prometheus instance you wish to modify. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->