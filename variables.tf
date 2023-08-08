variable "key_vault_key" {
  type = map(object({
    curve           = optional(string)
    expiration_date = optional(string)
    key_opts        = list(string)
    key_size        = optional(number)
    key_type        = string
    key_vault_id    = string
    name            = string
    not_before_date = optional(string)
    tags            = optional(map(string))
    rotation_policy = optional(object({
      expire_after         = optional(string)
      notify_before_expiry = optional(string)
      automatic = optional(object({
        time_after_creation = optional(string)
        time_before_expiry  = optional(string)
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = <<-EOT
 - `curve` - (Optional) Specifies the curve to use when creating an `EC` key. Possible values are `P-256`, `P-256K`, `P-384`, and `P-521`. This field will be required in a future release if `key_type` is `EC` or `EC-HSM`. The API will default to `P-256` if nothing is specified. Changing this forces a new resource to be created.
 - `expiration_date` - (Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
 - `key_opts` - (Required) A list of JSON web key operations. Possible values include: `decrypt`, `encrypt`, `sign`, `unwrapKey`, `verify` and `wrapKey`. Please note these values are case sensitive.
 - `key_size` - (Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. *Note*: This field is required if `key_type` is `RSA` or `RSA-HSM`. Changing this forces a new resource to be created.
 - `key_type` - (Required) Specifies the Key Type to use for this Key Vault Key. Possible values are `EC` (Elliptic Curve), `EC-HSM`, `RSA` and `RSA-HSM`. Changing this forces a new resource to be created.
 - `key_vault_id` - (Required) The ID of the Key Vault where the Key should be created. Changing this forces a new resource to be created.
 - `name` - (Required) Specifies the name of the Key Vault Key. Changing this forces a new resource to be created.
 - `not_before_date` - (Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
 - `tags` - (Optional) A mapping of tags to assign to the resource.

 ---
 `rotation_policy` block supports the following:
 - `expire_after` - (Optional) Expire a Key Vault Key after given duration as an [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations).
 - `notify_before_expiry` - (Optional) Notify at a given duration before expiry as an [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations). Default is `P30D`.

 ---
 `automatic` block supports the following:
 - `time_after_creation` - (Optional) Rotate automatically at a duration after create as an [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations).
 - `time_before_expiry` - (Optional) Rotate automatically at a duration before expiry as an [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations).

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Key Vault Key.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Key Vault Key.
 - `read` - (Defaults to 30 minutes) Used when retrieving the Key Vault Key.
 - `update` - (Defaults to 30 minutes) Used when updating the Key Vault Key.
EOT
  default = {}
  nullable    = false
}

variable "key_vault_location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  nullable    = false
}

variable "key_vault_name" {
  type        = string
  description = "(Required) Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name."
  nullable    = false
}

variable "key_vault_resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
  nullable    = false
}

variable "key_vault_sku_name" {
  type        = string
  description = "(Required) The Name of the SKU used for this Key Vault. Possible values are `standard` and `premium`."
  nullable    = false
}

variable "key_vault_tenant_id" {
  type        = string
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  nullable    = false
}

variable "key_vault_access_policy" {
  type = list(object({
    application_id          = string
    certificate_permissions = list(string)
    key_permissions         = list(string)
    object_id               = string
    secret_permissions      = list(string)
    storage_permissions     = list(string)
    tenant_id               = string
  }))
  default     = null
  description = <<-EOT
 - `application_id` - (Optional) The object ID of an Application in Azure Active Directory.
 - `certificate_permissions` - (Optional) List of certificate permissions, must be one or more from the following: `Backup`, `Create`, `Delete`, `DeleteIssuers`, `Get`, `GetIssuers`, `Import`, `List`, `ListIssuers`, `ManageContacts`, `ManageIssuers`, `Purge`, `Recover`, `Restore`, `SetIssuers` and `Update`.
 - `key_permissions` - (Optional) List of key permissions. Possible values are `Backup`, `Create`, `Decrypt`, `Delete`, `Encrypt`, `Get`, `Import`, `List`, `Purge`, `Recover`, `Restore`, `Sign`, `UnwrapKey`, `Update`, `Verify`, `WrapKey`, `Release`, `Rotate`, `GetRotationPolicy` and `SetRotationPolicy`.
 - `object_id` - (Required) The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.
 - `secret_permissions` - (Optional) List of secret permissions, must be one or more from the following: `Backup`, `Delete`, `Get`, `List`, `Purge`, `Recover`, `Restore` and `Set`.
 - `storage_permissions` - (Optional) List of storage permissions, must be one or more from the following: `Backup`, `Delete`, `DeleteSAS`, `Get`, `GetSAS`, `List`, `ListSAS`, `Purge`, `Recover`, `RegenerateKey`, `Restore`, `Set`, `SetSAS` and `Update`.
 - `tenant_id` - (Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Must match the `tenant_id` used above.
EOT
}

variable "key_vault_contact" {
  type = set(object({
    email = string
    name  = optional(string)
    phone = optional(string)
  }))
  default     = null
  description = <<-EOT
 - `email` - (Required) E-mail address of the contact.
 - `name` - (Optional) Name of the contact.
 - `phone` - (Optional) Phone number of the contact.
EOT
}

variable "key_vault_enable_rbac_authorization" {
  type        = bool
  default     = null
  description = "(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
}

variable "key_vault_enabled_for_deployment" {
  type        = bool
  default     = null
  description = "(Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
}

variable "key_vault_enabled_for_disk_encryption" {
  type        = bool
  default     = null
  description = "(Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
}

variable "key_vault_enabled_for_template_deployment" {
  type        = bool
  default     = null
  description = "(Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
}

variable "key_vault_network_acls" {
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(set(string))
    virtual_network_subnet_ids = optional(set(string))
  })
  default     = null
  description = <<-EOT
 - `bypass` - (Required) Specifies which traffic can bypass the network rules. Possible values are `AzureServices` and `None`.
 - `default_action` - (Required) The Default Action to use when no rules match from `ip_rules` / `virtual_network_subnet_ids`. Possible values are `Allow` and `Deny`.
 - `ip_rules` - (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
 - `virtual_network_subnet_ids` - (Optional) One or more Subnet IDs which should be able to access this Key Vault.
EOT
}

variable "key_vault_public_network_access_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Whether public network access is allowed for this Key Vault. Defaults to `true`."
}

variable "key_vault_purge_protection_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Is Purge Protection enabled for this Key Vault?"
}

variable "key_vault_soft_delete_retention_days" {
  type        = number
  default     = null
  description = "(Optional) The number of days that items should be retained for once soft-deleted. This value can be between `7` and `90` (the default) days."
}

variable "key_vault_tags" {
  type        = map(string)
  default     = null
  description = "(Optional) A mapping of tags to assign to the resource."
}

variable "key_vault_timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<-EOT
 - `create` - (Defaults to 30 minutes) Used when creating the Key Vault.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Key Vault.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Key Vault.
 - `update` - (Defaults to 30 minutes) Used when updating the Key Vault.
EOT
}
