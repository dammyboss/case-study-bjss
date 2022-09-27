## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_source_control.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_source_control) | resource |
| [azurerm_eventgrid_event_subscription.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_service_plan.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.functionstorage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.container2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_windows_function_app.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) | resource |
| [azurerm_windows_web_app.webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | RG location in Azure | `string` | n/a | yes |
| <a name="input_resource_group_name_1"></a> [resource\_group\_name\_1](#input\_resource\_group\_name\_1) | RG name in Azure | `string` | n/a | yes |
| <a name="input_resource_group_name_2"></a> [resource\_group\_name\_2](#input\_resource\_group\_name\_2) | RG name in Azure | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Storage Account name in Azure | `string` | n/a | yes |
| <a name="input_storage_account_name_function"></a> [storage\_account\_name\_function](#input\_storage\_account\_name\_function) | function Storage Account name in Azure | `string` | n/a | yes |
| <a name="input_storage_container_name_1"></a> [storage\_container\_name\_1](#input\_storage\_container\_name\_1) | Storage Container name in Azure | `string` | n/a | yes |
| <a name="input_storage_container_name_2"></a> [storage\_container\_name\_2](#input\_storage\_container\_name\_2) | Storage Container name in Azure | `string` | n/a | yes |

## Outputs

No outputs.
