# Lab 01 — Providers, Version Constraints & the Lock File

**Objectives:** 004 Objective 1 (IaC concepts) & Objective 2 (purpose of Terraform / providers)

## What was built

- `terraform.tf`: `required_providers` for `hashicorp/random`, plus a default and an aliased (`alt`) provider configuration.
- `main.tf`: `random_pet.cat` (default provider) and `random_pet.dog` (`provider = random.alt`).

## Key rules learned (with evidence)

### Version constraints (`~>`, pessimistic operator)
Constrains the **rightmost** version segment.

| Constraint | Segments | Allows |
|---|---|---|
| `~> 3.0` | two | >= 3.0.0, < 4.0.0 |
| `~> 3.5` | two | >= 3.5.0, < 4.0.0 |
| `~> 3.5.0` | three | >= 3.5.0, < 3.6.0 |

- Constraint = allowed *range*; lock file records the *actual* selected version.
- With `~> 3.5`, `init` installed **v3.9.0** (newest in range), not 3.5.x.

### `init` vs `init -upgrade` (conservatism)
| Scenario | Behavior |
|---|---|
| Locked version satisfies new constraint | `init` keeps locked version |
| Locked version violates new constraint | `init` **errors**, demands `-upgrade` |
| `init -upgrade` | Re-resolves to newest allowed, rewrites lock |

- Observed: constraint `~> 3.5.0` with 3.9.0 locked → error; `-upgrade` → 3.5.1.
- Terraform never changes provider version unless forced. (Contrast with npm.)

### Requirement vs Configuration (the layering)
| Layer | Count | Holds |
|---|---|---|
| Requirement (`required_providers`) | exactly ONE per provider | `source` + `version` |
| Configuration (`provider "x" {}`) | zero / one / many | runtime settings (region, profile, alias) |

- `version` belongs ONLY in `required_providers`. Putting `version` in a `provider {}` block = error.
- One requirement covers the default AND all aliased configurations. No per-alias requirement.

### Default vs Aliased configurations (the asymmetry)
- **Default** config can be **implicit**: omit `provider "random" {}` and Terraform synthesizes an empty default (valid because random needs no mandatory args).
- **Aliased** config is **never implicit**: referencing `random.alt` requires an explicit `provider "random" { alias = "alt" }` block, or → error.

| Removed block | Result |
|---|---|
| Aliased block (resource still refs `random.alt`) | ❌ "Provider configuration not present" |
| Default block (provider needs no args) | ✅ Works — implicit default synthesized |

### Aliases — when justified
- Aliases hold the *same provider* with *distinct settings* (multi-region, multi-account, multiple k8s clusters).
- For a config-less provider like `random`, an alias is **ceremonial** (no differing config). Fine for practice; not real-world.

### Reading errors
- The error **title** is authoritative (`Provider configuration not present`). The **body** may describe the common trigger (state orphan) and can mislead on edge cases. Read the title first.

### Locks (two different things)
- **Provider lock** (`.terraform.lock.hcl`): reproducible provider versions + hashes; committed to VCS; persistent.
- **State lock**: concurrency control enforced by the backend; ephemeral (held only during an operation); shines with remote backends.

## Teach-back completed
- Required provider vs provider configuration ✓ (after correction)
- Version constraint vs lock selection ✓
- Provider lock vs state lock ✓
- Default omission vs mandatory alias declaration ✓
