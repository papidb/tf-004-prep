# Lab 03 — Values, Expressions & Variable Precedence (Day 3, Objective 4)

## Config summary
- `environment` object var (name, instance_count), `tier` string (default "standard"), `pet_names` list, `ssh_cidr` string with validation.
- `random_pet.server_pets` via `for_each = toset([...])`; `random_pet.count_pets` via `count`.
- Locals: `name_prefix` (interpolation), `is_prod` (bool from `==`), `upper_names` (`for` expr).
- Outputs: map (`{k => v}`), list (`[v]`), `resolved_tier`.

## `for` expressions (official term)
- Brackets decide the RESULT TYPE: `[ ... : v ]` = tuple (list-like); `{ ... : k => v }` = object (map-like, `=>` mandatory).
- Doc anchor: language/expressions/for → "Result Types". Also: `if` filter, `...` grouping mode (map of lists), lexical ordering when converting unordered→ordered.

## Variable precedence (PROVEN empirically, lowest → highest)
1. `default` in variable block
2. `TF_VAR_name` environment variable  ← LOWEST of real values (beats only default)
3. `terraform.tfvars`                   ← beats env var (KEY MISS: intuition says env wins, it does NOT)
4. `*.auto.tfvars` (alphabetical among multiple)  ← beats terraform.tfvars (load order = override order)
5. `-var` / `-var-file` on CLI           ← highest; between them, LAST on command line wins (positional, not type-based)
- Source of truth: terraform internal/command/arguments/vars.go CollectValues — env, then implicit files, then CLI; maps.Copy overwrites.
- Proven with `terraform console` across 5 rounds + a CLI-order flip showing -var-file beating -var when it came last.

## Variable/local/output rename → NO resource diff
- Renaming a variable/local/output, or changing values that only flow into outputs, produces NO resource changes.
- Terraform diffs resource ARGUMENTS and IDENTITY, not source text. `length: 2->4` diffs (identity arg); a var rename does not.

## Custom condition: variable validation
- `validation { condition = ...; error_message = ... }` inside a variable block.
- Robust /32 check: `endswith(var.ssh_cidr, "/32") && can(cidrhost(var.ssh_cidr, 0))`.
  - `endswith` alone is weak — doesn't verify the rest is a valid IP. `can(cidrhost(...))` proves structural CIDR validity.
- Multiple validation blocks all evaluate; ALL failures reported at once. `0.0.0.0/0` fired BOTH blocks.
- Validation rejects at PLAN phase (variable resolution), before any resource is touched.

## count vs for_each (address + the index-shift trap)
- `count` → integer index, bare: `random_pet.count_pets[0]` / `[1]` / `[2]`.
- `for_each` → string key, quoted: `random_pet.server_pets["api"]`.
- INDEX-SHIFT TRAP (observed): pet_names ["web","api","db"] → ["web","db"] (remove middle) gave:
  `Plan: 1 to add, 0 to change, 2 to destroy`.
  - [0] web unchanged; [1] api→db "forces replacement"; [2] db DESTROYED.
  - The already-existing "db" got destroyed+recreated purely because its INDEX shifted 2→1.
- for_each with same removal → `0 add, 0 change, 1 destroy` (only "api" dies; "web"/"db" keys stable).
- RULE: count ties identity to POSITION (middle edits cascade); for_each ties identity to STABLE KEY. Prefer for_each when the collection can change.
