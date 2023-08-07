# tf_az_key_vault


```

module "key-vault" {
  source  = "kumarvna/key-vault/azurerm"
  version = "2.2.0"

  # By default, this module will not create a resource group and expect to provide
  # a existing RG name to use an existing resource group. Location will be same as existing RG.
  # set the argument to `create_resource_group = true` to create new resrouce.
  resource_group_name        = "rg-shared-westeurope-01"
  key_vault_name             = "demo-project-shard"
  key_vault_sku_pricing_tier = "premium"

  # Once `Purge Protection` has been Enabled it's not possible to Disable it
  # Deleting the Key Vault with `Purge Protection` enabled will schedule the Key Vault to be deleted
  # The default retention period is 90 days, possible values are from 7 to 90 days
  # use `soft_delete_retention_days` to set the retention period
  enable_purge_protection = false
  # soft_delete_retention_days = 90

  # Access policies for users, you can provide list of Azure AD users and set permissions.
  # Make sure to use list of user principal names of Azure AD users.
  access_policies = [
    {
      azure_ad_user_principal_names = ["user1@example.com", "user2@example.com"]
      key_permissions               = ["get", "list"]
      secret_permissions            = ["get", "list"]
      certificate_permissions       = ["get", "import", "list"]
      storage_permissions           = ["backup", "get", "list", "recover"]
    },

    # Access policies for AD Groups
    # to enable this feature, provide a list of Azure AD groups and set permissions as required.
    {
      azure_ad_group_names    = ["ADGroupName1", "ADGroupName2"]
      key_permissions         = ["get", "list"]
      secret_permissions      = ["get", "list"]
      certificate_permissions = ["get", "import", "list"]
      storage_permissions     = ["backup", "get", "list", "recover"]
    },

    # Access policies for Azure AD Service Principlas
    # To enable this feature, provide a list of Azure AD SPN and set permissions as required.
    {
      azure_ad_service_principal_names = ["azure-ad-dev-sp1", "azure-ad-dev-sp2"]
      key_permissions                  = ["get", "list"]
      secret_permissions               = ["get", "list"]
      certificate_permissions          = ["get", "import", "list"]
      storage_permissions              = ["backup", "get", "list", "recover"]
    }
  ]

  # Create a required Secrets as per your need.
  # When you Add `usernames` with empty password this module creates a strong random password
  # use .tfvars file to manage the secrets as variables to avoid security issues.
  secrets = {
    "message" = "Hello, world!"
    "vmpass"  = ""
  }

  # Creating Private Endpoint requires, VNet name and address prefix to create a subnet
  # By default this will create a `privatelink.vaultcore.azure.net` DNS zone.
  # To use existing private DNS zone specify `existing_private_dns_zone` with valid zone name
  enable_private_endpoint       = true
  virtual_network_name          = "vnet-shared-hub-westeurope-001"
  private_subnet_address_prefix = ["10.1.5.0/27"]
  # existing_private_dns_zone     = "demo.example.com"

  # (Optional) To enable Azure Monitoring for Azure Application Gateway
  # (Optional) Specify `storage_account_id` to save monitoring logs to storage.
  log_analytics_workspace_id = var.log_analytics_workspace_id
  #storage_account_id         = var.storage_account_id

  # Adding additional TAG's to your Azure resources
  tags = {
    ProjectName  = "demo-project"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}

```

<!-- BEGIN_TF_DOCS -->
# Terraform Module to create AZ Resources

## Contributing
If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

## Usage


## Providers

| Name | Version |
|------|---------|
| azuread | n/a |
| azurerm | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azuread_group.adgrp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.adspn](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.adusr](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.rgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_policies | List of access policies for the Key Vault. | `list` | <pre>[<br>  {<br>    "azure_ad_user_principal_names": [<br>      "nelsonrp24_hotmail.com#EXT#@nelsonrp24hotmail.onmicrosoft.com"<br>    ],<br>    "certificate_permissions": [<br>      "Get",<br>      "Import",<br>      "List"<br>    ],<br>    "key_permissions": [<br>      "Get",<br>      "List"<br>    ],<br>    "secret_permissions": [<br>      "Get",<br>      "List"<br>    ],<br>    "storage_permissions": [<br>      "Backup",<br>      "Get",<br>      "List",<br>      "Recover"<br>    ]<br>  }<br>]</pre> | no |
| certificate\_contacts | Contact information to send notifications triggered by certificate lifetime events | <pre>list(object({<br>    email = string<br>    name  = optional(string)<br>    phone = optional(string)<br>  }))</pre> | `[]` | no |
| create\_resource\_group | Whether to create resource group and use it for all networking resources | `bool` | `false` | no |
| enable\_private\_endpoint | Manages a Private Endpoint to Azure Container Registry | `bool` | `false` | no |
| enable\_purge\_protection | Is Purge Protection enabled for this Key Vault? | `bool` | `false` | no |
| enable\_rbac\_authorization | Specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions | `bool` | `false` | no |
| enabled\_for\_deployment | Allow Virtual Machines to retrieve certificates stored as secrets from the key vault. | `bool` | `true` | no |
| enabled\_for\_disk\_encryption | Allow Disk Encryption to retrieve secrets from the vault and unwrap keys. | `bool` | `true` | no |
| enabled\_for\_template\_deployment | Allow Resource Manager to retrieve secrets from the key vault. | `bool` | `true` | no |
| existing\_private\_dns\_zone | Name of the existing private DNS zone | `string` | `null` | no |
| existing\_subnet\_id | The resource id of existing subnet | `string` | `null` | no |
| existing\_vnet\_id | The resoruce id of existing Virtual network | `string` | `null` | no |
| key\_vault\_name | The Name of the key vault | `string` | `""` | no |
| key\_vault\_sku\_pricing\_tier | The name of the SKU used for the Key Vault. The options are: `standard`, `premium`. | `string` | `"standard"` | no |
| kv\_diag\_logs | Keyvault Monitoring Category details for Azure Diagnostic setting | `list(string)` | <pre>[<br>  "AuditEvent",<br>  "AzurePolicyEvaluationDetails"<br>]</pre> | no |
| location | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `""` | no |
| log\_analytics\_workspace\_id | Specifies the ID of a Log Analytics Workspace where Diagnostics Data to be sent | `string` | `null` | no |
| network\_acls | Network rules to apply to key vault. | <pre>object({<br>    bypass                     = string<br>    default_action             = string<br>    ip_rules                   = list(string)<br>    virtual_network_subnet_ids = list(string)<br>  })</pre> | `null` | no |
| private\_subnet\_address\_prefix | address prefix of the subnet for private endpoints | `string` | `null` | no |
| random\_password\_length | The desired length of random password created by this module | `number` | `32` | no |
| resource\_group\_name | A container that holds related resources for an Azure solution | `string` | `""` | no |
| secrets | A map of secrets for the Key Vault. | `map(string)` | `{}` | no |
| soft\_delete\_retention\_days | The number of days that items should be retained for once soft-deleted. The valid value can be between 7 and 90 days | `number` | `90` | no |
| storage\_account\_id | The name of the storage account to store the all monitoring logs | `string` | `null` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| virtual\_network\_name | The name of the virtual network | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_vault\_id | The ID of the Key Vault. |
| key\_vault\_name | Name of key vault created. |
| key\_vault\_uri | The URI of the Key Vault, used for performing operations on keys and secrets. |
<!-- END_TF_DOCS -->
