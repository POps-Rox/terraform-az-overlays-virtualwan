# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#------------------------------------------------------------
# Local Tags configuration - Default (required). 
#------------------------------------------------------------
locals {
  default_tags = var.default_tags_enabled ? {
    env      = var.environment
    workload = var.workload_name
  } : {}

  resource_group_tags = merge(var.tags, {
    DeployedBy = format("AzureNoOpsTF [%s]", terraform.workspace)
  })

  effective_resource_group_tags = merge(local.default_tags, local.resource_group_tags)
}
