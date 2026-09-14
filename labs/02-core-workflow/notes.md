# Lab 02 — Core CLI Workflow (Day 2, Objective 3)

## Config
- `random_pet.cat` and `random_pet.dog`, both `length = var.length` (number, no default → must pass `-var`).
- Provider `hashicorp/random ~> 3.5`, resolved to v3.9.1 in `.terraform.lock.hcl`.

## Exit codes (observed)
- `fmt -check`: **0** = all formatted (silent). **non-zero** (saw **3**) = a file needs formatting, prints filename. It is NOT a linter — normalizes indentation/`=` alignment, collapses *runs* of blank lines, tolerates a single blank line.
- `plan -detailed-exitcode`: **0** = no changes, **1** = error, **2** = changes present. (2 is success-with-diff, not an error. This is how automation detects drift without parsing text.)

## Core workflow (each run individually)
`fmt -check` → `init` → `validate` → `plan -out=tfplan` → `show tfplan` → `apply tfplan` → `plan -detailed-exitcode`
- `init` created `.terraform.lock.hcl` (locks v3.9.1) and `.terraform/` (plugin binary).
- `validate` needs `init` first (must know provider schemas); does NOT contact infra or need creds. Exit 0 = valid.
- `-out=tfplan` freezes the plan to a file. The file is a **binary ZIP** (`PK\x03\x04`), not editable; read it with `terraform show tfplan`.
- `terraform show` with NO file → current **state**. With a plan file → the **planned diff**.
- **`apply tfplan` does NOT prompt** — a saved plan is already the approval. `apply` (no file) re-plans and prompts yes/no. Two ways to skip the prompt: `-auto-approve` OR feed a saved plan file. (Error category C — command confusion.)

## Replace trigger vs config trigger (both produce `-/+`)
- Config change on identity attribute (`length: 2 -> 4`) → `# forces replacement`.
- `-replace=ADDRESS` flag → `will be replaced, as requested` (no config diff needed).

## Flag semantics (Terraform 1.12, verified against official docs)
- `init -migrate-state`: reinitialize after backend change AND **copy existing state into the new backend**.
- `init -reconfigure`: reinitialize after backend change, **do NOT migrate** — disregards prior cached backend config; old state stays in old backend, not copied. NOT interchangeable with `-migrate-state` (migrate = copy, reconfigure = don't copy).
- `init -upgrade`: ignore prior selections, pick newest providers AND modules **within version constraints**; can update the lock file.
- `-replace=ADDRESS` (plan or apply, fresh plan only): force destroy-and-recreate of one instance even if it would otherwise be unchanged/updated. Reviewable replacement for old `terraform taint`.
- `-refresh-only` (plan/apply): a planning **mode**. Updates **state + root outputs** to match out-of-band reality; never modifies infrastructure. Normal plan reverts drift; refresh-only accepts it. NOTE: `random_*` cannot demo this (no backing API) — proper demo is Day 6/7 with Docker.
- `-target=ADDRESS`: planning **option**. Restricts planning to the address + its dependencies. Exceptional only — hides real pending work (proven: targeting `cat` hid that `dog` needed creating), Terraform warns the plan "may not represent all changes." Recovery tool, not routine partial-apply.

## Observed contrast (targeting)
- `plan -target=random_pet.cat` → "No changes" + targeting warning; `dog` hidden.
- normal `plan` → "`random_pet.dog` will be created", "1 to add". Same config/state; only `-target` differed.
