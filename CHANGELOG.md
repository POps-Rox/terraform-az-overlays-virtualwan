# v2.0.0 - 2026-05-11

Changed
- **BREAKING**: Upgrade `azurerm` provider to `~> 4.20` (was `~> 3.116`).
- **BREAKING**: Raise minimum Terraform CLI to `>= 1.10` (was `>= 1.9`).
- Declare `azapi ~> 2.0` provider for fleet alignment.
- Examples: pin matching provider versions; add `subscription_id` env-var hint
  (azurerm 4.x requires `ARM_SUBSCRIPTION_ID` for apply; `validate` unaffected).
- No resource files reference `azurerm_virtual_hub` in this scaffold-stage overlay, so no `virtual_hub` argument renames are applied in this PR. When the scaffolding lands, future PRs must verify against the 4.x `azurerm_virtual_hub` schema (the brief flagged renames as a future concern).

Notes
- Cross-module dependency: transitive sibling overlays must also ship 4.x-compatible
  releases before this version can resolve cleanly via `terraform init -upgrade`.

# v1.0.0 - <date>

Added
- Add Something you added
