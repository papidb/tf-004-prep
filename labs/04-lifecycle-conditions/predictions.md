# Lab 04 — Predictions

## Piece 1: dependencies (implicit vs depends_on)

### P1 — After apply, bump `random_pet.a` length (forces new `a.id`)
- **b → REPLACED (destroy + create).**
  Reason: `b.keepers["a_id"]` references `random_pet.a.id`. When `a`'s id
  changes, the `keepers` map changes. `keepers` forces replacement by design
  (that is its whole purpose), so `b` is destroyed and recreated.
- **c → NO CHANGE.**
  Reason: `c` depends on `a` only via `depends_on` — an ORDERING edge, not a
  DATA edge. `c` consumes no attribute of `a`, so a new `a.id` does not flow
  into any of `c`'s arguments. Nothing in `c` changed → no diff.
  `depends_on` controls order of operations, never whether a change propagates.

### P2 — `terraform graph` edges
- Edge `b → a` exists (implicit, via `keepers` referencing `a.id`).
- Edge `c → a` exists (explicit, via `depends_on`), even though `c` references
  no attribute of `a`. That is exactly what `depends_on` adds to the graph.
