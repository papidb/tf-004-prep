# Lab 04 — Dependencies, Lifecycle, Validation & Secret Semantics (Day 4, Objective 4)

## Config summary
- `random_pet.a` (length = var.pet_length, `create_before_destroy`, passing `postcondition`).
- `random_pet.b` (keepers ref `a.id` → implicit dep; `precondition` a.length >= 2).
- `random_pet.c` (`depends_on = [a]` → ordering-only edge).
- `variable "pet_length"` with `validation` (1..5).
- top-level `check "pet_names_distinct"` (a.id != b.id).

## 1. Dependencies: implicit vs depends_on
- **Implicit** = one resource REFERENCES an attribute of another (e.g. `keepers = { x = random_pet.a.id }`). Terraform builds the graph by scanning for these reference expressions.
- **depends_on** = explicit ORDERING edge for a real-but-hidden dependency (b needs a first, but b's args contain NO reference to a). Last resort.
- PROVEN: bump a → b (keepers) REPLACED; c (depends_on) NOT in plan at all. depends_on carries ordering, never data. A change propagates only through a REFERENCE.

## 2. Update vs replace = PROVIDER SCHEMA (ForceNew)  [KEY MISS - K]
- Whether an arg change is in-place or replacement is decided by the provider schema (ForceNew), NOT readable from HCL.
- `random_pet.length` is ForceNew → `length 2 -> 3 # forces replacement`.
- Read update-vs-replace from the plan's `# forces replacement`, never infer from config.

## 3. create_before_destroy + the "deposed" object
- Default replacement = destroy-then-create (`-/+`). c_b_d flips to create-then-destroy (`+/-`).
- INFECTION: c_b_d propagates to dependents. Observed order when a (c_b_d) + b both replaced:
  1. destroy old b  2. create new a  3. create new b  4. destroy old a (LAST, as "deposed object")
- INVARIANT: a dependent never references a destroyed object; there's always a live target. Old parent (a) waits until dependents are recreated & reattached.
- **Deposed object** = old instance set aside in state during c_b_d replacement, destroyed at the end. A crash/failed apply mid-replacement can STRAND it (observed: cleaned up on next apply as "left over from a partially-failed replacement").

## 4. prevent_destroy + the block-removal trap
- `prevent_destroy = true` → HARD ERROR at plan-eval if a plan would destroy the resource.
- Atomic: on `terraform destroy` it errors BEFORE touching anything → NOTHING destroyed, not even unprotected peers (b survived).
- TRAP: delete the whole resource block → plan happily schedules destroy ("not in configuration"), NO error. prevent_destroy is a CONFIG directive, not stored in state; removing the block removes the guardrail. It only protects a resource while still DECLARED. (Also defeated by `state rm`.)

## 5. Custom conditions — four-way decision table (GATE)
| Construct | Where | Fires | Failure | Left in state on failure |
|---|---|---|---|---|
| variable `validation` | variable block | var eval (pre-plan) | ERROR "Invalid value for variable" | nothing (clean) |
| `precondition` | resource lifecycle | BEFORE resource acts | ERROR "Resource precondition failed" | guarded resource never created (clean gate) |
| `postcondition` | resource lifecycle | AFTER result known | ERROR "Resource postcondition failed" | **object IS created & kept** (partial state; may strand deposed) |
| `check`+`assert` | top-level check block | final separate phase | **WARNING**; run SUCCEEDS | operation completes |

### Discriminator (under 20s)
- Variable's own value/format → **validation**
- Assumption about OTHER resources/data before this one acts → **precondition**
- This resource's OWN result after built (uses `self`) → **postcondition**
- Monitor, must not block → **check** (warning)

### self keyword
- `self.<attr>` usable ONLY in postcondition (result is known by then). precondition can't use `self` — resource attrs don't exist pre-creation. Timing argument.

### NO ROLLBACK  [KEY MISS - K]
- Terraform has NO transactions. Failed postcondition → created object STAYS in state (observed `poorly-beloved-tiger` survived), run halts, downstream skipped → partial apply.
- pre = clean gate (nothing made); post = created-then-checked (object survives, messy).

## prevent_destroy vs prevent-via-conditions
- prevent_destroy blocks destroys of a DECLARED resource; conditions block on assertion failures. Different mechanisms.

## Evidence trail (observed)
- validation: `plan -var pet_length=10` → "Invalid value for variable", Planning failed.
- precondition: `plan -var pet_length=1` → "Resource precondition failed" (a.length is 1).
- postcondition: forced `length(self.id) > 1000`, applied → new a created THEN "Resource postcondition failed"; `state show` proved a kept; old a stranded as deposed, reaped next apply.
- check: inverted to `a.id == b.id` → "Warning: Check block assertion failed", "No changes" (succeeded).
