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

### Passing aliased providers into child modules (extension lab)
Child modules have their OWN `terraform { required_providers {} }` block — each module declares its own dependency contract.

Two halves (parameter / argument):
- **Child declares the slot** — `configuration_aliases = [random.alt]` inside the child's `required_providers`. This is a PARAMETER: "I expect an aliased config passed in, called random.alt internally." It is NOT a provider configuration.
- **Root fills the slot** — `providers = { random.alt = random.alt }` on the `module` block. ARGUMENT at the call site.
  - Map rule: **key = what the child expects, value = what the root provides.**
  - Trap: `{ random = random.alt }` is wrong; child declared `random.alt`, so key must be `random.alt`.

Inheritance asymmetry (repeats the root-level rule at the module boundary):
- Default (unaliased) config → inherited by child IMPLICITLY.
- Aliased config → NEVER implicit; must be passed via `providers` map.

Meta-argument singular vs plural (exam trap):
- `provider  = aws.west`  → **resource** meta-argument (one resource picks a config).
- `providers = { ... }`   → **module** meta-argument (map wiring root configs into a child).

Module resource addressing: `module.<name>.<type>.<name>` e.g. `module.dog.random_pet.module_pet`.

Removing `configuration_aliases` while root still passes the provider:
- Produces a WARNING ("Reference to undefined provider"), not an error — legacy backward-compat leniency; Terraform guesses the source. Points at the root (the reference site); fix is in the child (re-add configuration_aliases).
- Contrast: undeclared alias at ROOT level = hard ERROR ("Provider configuration not present").

## Teach-back completed
- Required provider vs provider configuration ✓ (after correction)
- Version constraint vs lock selection ✓
- Provider lock vs state lock ✓
- Default omission vs mandatory alias declaration ✓
- providers map vs configuration_aliases (argument vs parameter) ✓
- Why removing configuration_aliases warns instead of errors ✓
