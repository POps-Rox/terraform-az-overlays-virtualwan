# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

mock_provider "azurerm" {}
mock_provider "azapi" {}

mock_provider "popsrox" {
  mock_data "popsrox_resource_name" {
    defaults = {
      result = "anoa-eus2-orders-dev-rg"
    }
  }
}

variables {
  location                = "eastus2"
  environment             = "dev"
  workload_name           = "orders"
  org_name                = "anoa"
  org_prefix              = "anoa"
  use_location_short_name = true
  tags = {
    CostCenter = "1234"
    Owner      = "platform"
  }
}

run "generated_name_tags_location_and_locks_disabled" {
  command = plan

  variables {
    custom_resource_group_name = null
    enable_resource_locks      = false
  }

  assert {
    condition     = output.resource_group_name == "anoa-eus2-orders-dev-rg"
    error_message = "Generated resource group name should be used when no custom name is provided."
  }

  assert {
    condition     = output.resource_group_location == var.location
    error_message = "Resource group location should pass through from var.location."
  }

  assert {
    condition = output.resource_group_tags == {
      env        = "dev"
      workload   = "orders"
      CostCenter = "1234"
      Owner      = "platform"
      DeployedBy = "AzureNoOpsTF [default]"
    }
    error_message = "Resource group tags should merge module defaults, caller tags, and DeployedBy."
  }

  assert {
    condition     = length(azurerm_management_lock.resource_group_level_lock) == 0
    error_message = "Resource group lock should not be planned when enable_resource_locks is false."
  }
}

run "custom_name_precedence_and_locks_enabled" {
  command = plan

  variables {
    custom_resource_group_name = "rg-orders-override"
    enable_resource_locks      = true
    lock_level                 = "ReadOnly"
  }

  assert {
    condition     = output.resource_group_name == "rg-orders-override"
    error_message = "custom_resource_group_name should override generated naming."
  }

  assert {
    condition     = length(azurerm_management_lock.resource_group_level_lock) == 1
    error_message = "Resource group lock should be planned when enable_resource_locks is true."
  }

  assert {
    condition     = azurerm_management_lock.resource_group_level_lock[0].name == "rg-orders-override-ReadOnly-lock"
    error_message = "Lock name should be based on the resolved resource group name and lock level."
  }

  assert {
    condition     = azurerm_management_lock.resource_group_level_lock[0].lock_level == "ReadOnly"
    error_message = "Lock level should pass through to the management lock."
  }
}

run "empty_custom_name_falls_back_to_generated_name" {
  command = plan

  variables {
    custom_resource_group_name = ""
    enable_resource_locks      = false
  }

  assert {
    condition     = output.resource_group_name == "anoa-eus2-orders-dev-rg"
    error_message = "An empty custom_resource_group_name should fall back to generated naming, not create an empty name."
  }
}
