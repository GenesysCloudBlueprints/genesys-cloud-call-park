Setups a public api integration using CX as Code and Terraform remote modules

## Usage

Shown below is an example of how to configure the remote module.

```hcl
module "integration" {
    source = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module.git?ref=v1.0.0"

    integration_name                = "GC Data Actions Integration Name"
    integration_creds_client_id     = "<client ID>"
    integration_creds_client_secret = "<client secret>"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a>[terraform](https://www.terraform.io/) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_genesyscloud"></a> [genesyscloud](https://registry.terraform.io/providers/MyPureCloud/genesyscloud/latest) | >= 1.0|

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="integration_name"></a> [integration_name](#integration\_\name)  | The name for the Genesys Cloud data actions integration. | `string` | yes |
| <a name="integration_creds_client_id"></a> [integration_creds_client_id](#integration\_\creds\_\client\_\id)  | The Genesys Cloud oauth client ID. | `string` | yes |
| <a name="integration_creds_client_secret"></a> [integration_creds_client_secret](#integration\_\creds\_\client\_\secret)  | The Genesys Cloud oauth client secret. | `string` | yes |

## Outputs

| Name | Description | Type | 
|------|-------------|------|
| <a name="integration_id"></a> [integration_id](#integration\_\id)  | The ID of the integration. | `string` |
| <a name="integration_name"></a> [integration_name](#integration\_\name)  | The name of the integration. | `string` | 
