resource "azurerm_key_vault" "this" {
  location                        = var.key_vault_location
  name                            = var.key_vault_name
  resource_group_name             = var.key_vault_resource_group_name
  sku_name                        = var.key_vault_sku_name
  tenant_id                       = var.key_vault_tenant_id
  enable_rbac_authorization       = var.key_vault_enable_rbac_authorization
  enabled_for_deployment          = var.key_vault_enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
  public_network_access_enabled   = var.key_vault_public_network_access_enabled
  purge_protection_enabled        = var.key_vault_purge_protection_enabled
  soft_delete_retention_days      = var.key_vault_soft_delete_retention_days
  tags                            = var.key_vault_tags

  dynamic "access_policy" {
    for_each = var.key_vault_access_policy == null ? [] : var.key_vault_access_policy
    content {
      application_id          = access_policy.value.application_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      object_id               = access_policy.value.object_id
      secret_permissions      = access_policy.value.secret_permissions
      storage_permissions     = access_policy.value.storage_permissions
      tenant_id               = access_policy.value.tenant_id
    }
  }
  dynamic "contact" {
    for_each = var.key_vault_contact == null ? [] : var.key_vault_contact
    content {
      email = contact.value.email
      name  = contact.value.name
      phone = contact.value.phone
    }
  }
  dynamic "network_acls" {
    for_each = var.key_vault_network_acls == null ? [] : [var.key_vault_network_acls]
    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }
  dynamic "timeouts" {
    for_each = var.key_vault_timeouts == null ? [] : [var.key_vault_timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

resource "azurerm_key_vault_key" "this" {
  for_each = var.key_vault_key

  key_opts        = each.value.key_opts
  key_type        = each.value.key_type
  key_vault_id    = each.value.key_vault_id
  name            = each.value.name
  curve           = each.value.curve
  expiration_date = each.value.expiration_date
  key_size        = each.value.key_size
  not_before_date = each.value.not_before_date
  tags            = each.value.tags

  dynamic "rotation_policy" {
    for_each = each.value.rotation_policy == null ? [] : [each.value.rotation_policy]
    content {
      expire_after         = rotation_policy.value.expire_after
      notify_before_expiry = rotation_policy.value.notify_before_expiry

      dynamic "automatic" {
        for_each = rotation_policy.value.automatic == null ? [] : [rotation_policy.value.automatic]
        content {
          time_after_creation = automatic.value.time_after_creation
          time_before_expiry  = automatic.value.time_before_expiry
        }
      }
    }
  }
  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

