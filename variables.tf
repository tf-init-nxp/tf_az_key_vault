variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = false
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "key_vault_name" {
  description = "The Name of the key vault"
  default     = ""
}

variable "key_vault_sku_pricing_tier" {
  description = "The name of the SKU used for the Key Vault. The options are: `standard`, `premium`."
  default     = "standard"
}

variable "enabled_for_deployment" {
  description = "Allow Virtual Machines to retrieve certificates stored as secrets from the key vault."
  default     = true
}

variable "enabled_for_disk_encryption" {
  description = "Allow Disk Encryption to retrieve secrets from the vault and unwrap keys."
  default     = true
}

variable "enabled_for_template_deployment" {
  description = "Allow Resource Manager to retrieve secrets from the key vault."
  default     = true
}

variable "enable_rbac_authorization" {
  description = "Specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions"
  default     = false
}

variable "enable_purge_protection" {
  description = "Is Purge Protection enabled for this Key Vault?"
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. The valid value can be between 7 and 90 days"
  default     = 90
}

variable "access_policies" {
  description = "List of access policies for the Key Vault."
  default     = []
}

variable "network_acls" {
  description = "Network rules to apply to key vault."
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = null
}

variable "secrets" {
  type        = map(string)
  description = "A map of secrets for the Key Vault."
  default     = {}
}

variable "random_password_length" {
  description = "The desired length of random password created by this module"
  default     = 32
}

variable "certificate_contacts" {
  description = "Contact information to send notifications triggered by certificate lifetime events"
  type = list(object({
    email = string
    name  = optional(string)
    phone = optional(string)
  }))
  default = []
}

variable "enable_private_endpoint" {
  description = "Manages a Private Endpoint to Azure Container Registry"
  default     = false
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = ""
}

variable "existing_vnet_id" {
  description = "The resoruce id of existing Virtual network"
  default     = null
}

variable "existing_subnet_id" {
  description = "The resource id of existing subnet"
  default     = null
}

variable "existing_private_dns_zone" {
  description = "Name of the existing private DNS zone"
  default     = null
}

variable "private_subnet_address_prefix" {
  description = "address prefix of the subnet for private endpoints"
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "Specifies the ID of a Log Analytics Workspace where Diagnostics Data to be sent"
  default     = null
}

variable "storage_account_id" {
  description = "The name of the storage account to store the all monitoring logs"
  default     = null
}

variable "kv_diag_logs" {
  description = "Keyvault Monitoring Category details for Azure Diagnostic setting"
  default     = ["AuditEvent", "AzurePolicyEvaluationDetails"]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
