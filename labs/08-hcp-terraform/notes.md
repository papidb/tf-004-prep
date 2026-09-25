# Lab 08 — HCP Terraform: Workspaces, Projects, Execution & Migration

Objective 8 (8a, 8c, workspace/project parts of 8b).

## What was built

- Fresh minimal config: `random_pet.hcp_demo` + `pet_name` output.
- Started on **local** backend, applied (`wondrous-filly`), then added a `cloud`
  block and migrated the state up to HCP.
- Org: `danielubenjamin-tf004`, workspace `tf004-day8-migration`, Default Project.

## The `cloud` block (modern HCP integration, replaces `backend "remote"`)

```hcl
terraform {
  cloud {
    organization = "danielubenjamin-tf004"
    workspaces {
      name = "tf004-day8-migration"   # created on init if absent
    }
  }
}
```

- Only **one** `cloud` block allowed per `terraform {}` block. Two = "Duplicate
  HCP Terraform configurations" error (hit this live).
- `cloud` block goes *inside* `terraform {}`, alongside `required_providers`.

## State migration (local -> HCP)

- `terraform init` after adding `cloud` detects backend change and prompts:
  *"Should Terraform migrate your existing state?"* -> yes copies local state up.
- Evidence the move happened:
  - `terraform.tfstate` -> **0 bytes** (drained).
  - `terraform.tfstate.backup` -> old 775-byte state kept as safety net.
  - `terraform state list` / `show` now read from HCP, still show `wondrous-filly`.

## Remote execution (THE key concept)

- `terraform plan` printed: `Running plan in HCP Terraform` + a **run URL**.
- Output header said **`on linux_amd64`** while my laptop is `darwin_arm64`.
  -> **proof the plan ran on HCP's remote worker VM, not my machine.**
- This is why a Docker-provider config breaks in **remote** mode: the remote
  worker is a throwaway Linux VM in HashiCorp's cloud with no access to my
  Mac's Docker socket / localhost / local files.

## Execution modes

| Mode | Where plan/apply runs | State | Run URL |
|------|----------------------|-------|---------|
| **Remote** (default) | HCP worker VM (`linux_amd64`) | HCP | yes |
| **Local** | my machine (`darwin_arm64`) | HCP | no (runs locally) |
| **Agent** | self-hosted agent in my network | HCP | via agent |

- Fix for Docker/localhost labs on HCP = **local** execution mode (or agent).

## Trap pairs (gate)

- **CLI workspace** = multiple named **state files** within ONE backend + ONE
  config (`terraform workspace new/select`, `terraform.workspace`). Isolates
  **state only**. Not necessarily local.
- **HCP workspace** = a full **managed unit**: state + run history + variables +
  execution mode + access. State is only one part.
- **Project** = container that **groups workspaces** for organization +
  **permissions** (grant team access at project level -> cascades to all its
  workspaces). Workspace lives in exactly one project; Default Project is the
  fallback.
- One-liner: **Project = folder, Workspace = file.**

## Gate results

- G1 (linux_amd64 proves remote) — correct.
- G2 (project vs workspace) — did not know initially; taught; then correctly
  said team access is granted at **project** level.
- G3 (local mode -> no run URL, runs on my machine) — correct.
