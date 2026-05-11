# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------------
# Azure Region Lookup
#----------------------------------------------------------------
# Azure Region Lookup. This module will lookup the Azure Region and return the short name for the region
module "mod_azure_region_lookup" {
  source = "github.com/POps-Rox/terraform-az-overlays-azregionslookup"

  azure_region = var.location
}

#---------------------------------------------------------------
# Resource Group Creation
#----------------------------------------------------------------

module "mod_rg" {
  source = "github.com/POps-Rox/terraform-az-overlays-resourcegroup"

  location                = var.location
  use_location_short_name = true # Use the short location name in the resource group name
  org_name                = var.org_prefix
  environment             = var.environment
  workload_name           = var.workload_name
  custom_rg_name          = var.custom_resource_group_name != null ? var.custom_resource_group_name : null

  // Tags
  add_tags = merge(var.tags, {
    DeployedBy = format("AzureNoOpsTF [%s]", terraform.workspace)
  }) # Tags to be applied to all resources
}

