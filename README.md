# terraform-grafana-config-module

## Terraform Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [grafana_dashboard.dashboard_from_file](https://registry.terraform.io/providers/grafana/grafana/2.1.0/docs/resources/dashboard) | resource |
| [grafana_data_source.data_source_from_map](https://registry.terraform.io/providers/grafana/grafana/2.1.0/docs/resources/data_source) | resource |
| [grafana_folder.dashboard_folders](https://registry.terraform.io/providers/grafana/grafana/2.1.0/docs/resources/folder) | resource |
| [aws_secretsmanager_secret_version.amg_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Contains the AWS Region that Grafana is running in. | `string` | `"us-east-1"` | no |
| <a name="input_dashboard_configs_folder"></a> [dashboard\_configs\_folder](#input\_dashboard\_configs\_folder) | The path to the dashboards folder where the configuration files are located. | `string` | n/a | yes |
| <a name="input_data_source_map"></a> [data\_source\_map](#input\_data\_source\_map) | A list of maps representing datasource information. Each map defines a data source with its type, name, and url. | `list(map(string))` | <pre>[<br>  {<br>    "data_source_name": "CloudName1",<br>    "data_source_type": "cloudwatch",<br>    "data_source_url": "https://cloudwatch.amazonaws.com"<br>  },<br>  {<br>    "data_source_name": "PromName1",<br>    "data_source_type": "prometheus",<br>    "data_source_url": "https://prometheus.amazonaws.com"<br>  },<br>  {<br>    "data_source_name": "PromName2",<br>    "data_source_type": "prometheus",<br>    "data_source_url": "https://prometheus2.amazonaws.com"<br>  }<br>]</pre> | no |
| <a name="input_grafana_asm_key"></a> [grafana\_asm\_key](#input\_grafana\_asm\_key) | Contains the Grafana API Token, given to the provider so that it can interact with grafana. | `string` | `"AMG_API_Token"` | no |
| <a name="input_grafana_auth"></a> [grafana\_auth](#input\_grafana\_auth) | The Auth token used to make API calls against grafana. | `any` | n/a | yes |
| <a name="input_grafana_url"></a> [grafana\_url](#input\_grafana\_url) | The url to your Grafana instance. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->