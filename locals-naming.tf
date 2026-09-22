locals {
  # Naming locals/constants
  name_prefix                          = lower(var.name_prefix)
  name_suffix                          = lower(var.name_suffix)
  anoa_slug                            = "rg" # add resource type (ie rg is Ressource Group)
  effective_custom_resource_group_name = try(trimspace(var.custom_resource_group_name), "") != "" ? var.custom_resource_group_name : null
  resource_name                        = var.custom_rg_name != "" ? var.custom_rg_name : data.popsrox_resource_name.rg.result
  rg_name                              = module.mod_rg.resource_group_name
}
