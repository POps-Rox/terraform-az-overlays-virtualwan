# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

output "resource_group_name" {
  value       = module.mod_rg.resource_group_name
  description = "Resource group name."
}

output "resource_group_id" {
  value       = module.mod_rg.resource_group_id
  description = "Resource group generated ID."
}

output "resource_group_location" {
  value       = module.mod_rg.resource_group_location
  description = "Resource group location."
}

output "resource_group_tags" {
  value       = local.effective_resource_group_tags
  description = "Effective tags applied to the resource group."
}
