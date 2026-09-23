# Terraform Associate 004: strict 12-day plan

## Mission

Pass the Terraform Associate 004 exam with reliable recall across every official objective, not merely the AWS topics you already use.

Your prior work gives you a real advantage: you have built VPCs, public and private subnets, routing, security groups, EC2, NAT, RDS, reusable modules, an S3 backend, environment-aware naming, variables, outputs, and templates. The main risk is uneven breadth. In particular, you must deliberately cover precise CLI behavior, variable precedence, lifecycle and validation semantics, state refactoring and import, and HCP Terraform terminology.

For these 12 days, do not read *Terraform in Action* cover to cover and do not start a large portfolio project. Use the official objectives as the syllabus, short destructive labs as memory anchors, and retrieval practice as the daily engine.

## How to use the supplied deck

- Import `Terraform_Associate_004_Scenario_Deck.apkg` into Anki. It creates eight objective subdecks.
- Raise the new-card limit to at least 30 so Anki does not hide cards assigned for a content day. Keep the review limit high enough to finish every due card.
- Study only the objective subdeck assigned for that day, then use the parent deck for mixed review from Day 7 onward.
- Press **Again** if you could not state the governing rule. Press **Hard** if you chose correctly but guessed or could not reject the distractors. Press **Good** only when both the answer and explanation were clear. Reserve **Easy** for rules you can teach from memory.
- The `.csv` file is the editable source. Every row contains the answer, rationale, official source, and tags. Edit or suspend a card if official documentation shows that its wording needs correction.
- The Markdown question bank contains the same 128 questions with collapsible answers for timed sessions outside Anki.

## Non-negotiable rules

1. Complete due Anki reviews before learning new cards.
2. Answer questions closed-book. Looking up the answer before committing to one does not count.
3. For every miss, record why your answer was wrong and why each tempting alternative was wrong.
4. Verify disputed answers in Terraform 1.12 HashiCorp documentation. Third-party keys are not authoritative.
5. No passive video block longer than 30 minutes without notes, a lab, or closed-book questions immediately afterward.
6. Do not skip HCP Terraform. It is a full official objective, even if your daily work is CLI and AWS focused.
7. Do not use alleged live-exam dumps. They are unverifiable, often contain errors, and train recognition of questionable wording instead of the documented behavior.
8. No new resource or book may be added after Day 3.
9. Keep one error log. Never scatter misses across notebooks.
10. Stop heavy study the evening before the exam and protect sleep.

## Daily operating loop

Use this loop on content days. Budget 3 hours. Mock days require 4 hours.

| Block | Time | Required output |
|---|---:|---|
| Due Anki reviews | 25 min | All due cards completed, 85% or better target |
| Closed-book retrieval | 15 min | Write what you remember about the day's objective |
| Official study | 45 min | Objective checklist annotated with unclear points |
| Break-and-fix lab | 55 min | One small scenario created, observed, and repaired |
| New Anki cards | 25 min | Today's objective subdeck completed |
| Scenario quiz | 20 min | 10 to 20 questions, timed |
| Teach-back and log | 10 min | Two-minute verbal explanation plus error-log updates |

On a mock day, replace official study and the lab with a 60-minute timed mock and 90 minutes of review. Review takes longer than the test because every miss and every guess must be explained.

## Readiness measures

HashiCorp does not publish the passing score or number of scored questions. These are internal standards, not claims about the exam cut score.

| Measure | Minimum gate |
|---|---:|
| Official objective checklist | Explain all 37 subobjectives without notes by Day 10 |
| Objective question sets | 80% by the end of the relevant day |
| Timed mixed mocks | 75% Day 7, 80% Day 9, 85% Day 11 |
| Anki review accuracy | 85% or better on Days 9 to 12 |
| Unexplained guesses | Zero by Day 11 |
| Timing | Finish a mock in 50 minutes, preserving 10 minutes for review |

If a mock is below its gate, do not take another mock immediately. Categorize every miss, repair the two weakest objectives using official docs and a lab, then retest the next day with unseen questions.

## The 12 days

### Day 1, D-12: baseline, IaC, fundamentals, providers

- Take the five [official sample questions](https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-questions-004) cold. Record confidence as well as correctness.
- Read objectives 1 and 2 in the [official review guide](https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-review-004).
- Complete Anki subdecks 01 and 02: 21 new cards.
- Lab: clone a tiny configuration into a clean directory; run `init`; inspect `.terraform.lock.hcl`; run `terraform providers`; change an allowed provider constraint; compare normal `init` with `init -upgrade` without applying infrastructure.
- Teach back: required provider versus provider configuration; version constraint versus lock selection; provider lock versus state lock.
- Gate: 80% on the Day 1 cards when repeated later the same day.

### Day 2, D-11: core CLI workflow

- Study objective 3 and complete subdeck 03: 16 new cards.
- Lab: run `fmt -check`, `validate`, speculative `plan`, `plan -out`, `show` on the saved plan, and `apply` of that saved plan. Use a no-cost provider or your existing safe sandbox.
- Deliberately test `plan -detailed-exitcode` and record exit codes for no change, change, and error.
- Explain when to use `-migrate-state`, `-reconfigure`, `-upgrade`, `-replace`, `-refresh-only`, and why `-target` is exceptional.
- Gate: identify the effect of each core command and flag without executing it.

### Day 3, D-10: configuration language, values, and repetition

- Study objective 4a through 4f. Complete the first 15 cards in subdeck 04.
- Lab: build one small resource or `terraform_data` example that uses a typed object input, a local value, a conditional, a `for` expression, `for_each`, a data source, and an output.
- Make the same variable appear in `TF_VAR_*`, `terraform.tfvars`, an `.auto.tfvars` file, and two ordered `-var-file` arguments. Predict the winner before every run.
- Revisit your earlier SSH CIDR mistake. Add variable validation that accepts only a `/32` for the administration CIDR.
- Gate: reproduce variable precedence from lowest to highest and distinguish count addresses from for_each addresses.

### Day 4, D-9: dependencies, lifecycle, validation, and secret semantics

- Finish the remaining 16 cards in subdeck 04.
- Lab: create one implicit dependency and one justified `depends_on`; rename or change an object to observe replacement; use `create_before_destroy` in a safe resource; add a failing variable validation, precondition, postcondition, and non-blocking check one at a time.
- Write a three-column comparison of `sensitive`, `ephemeral`, and provider write-only arguments. Include what appears in CLI output, plan, and state.
- Explain why `prevent_destroy` does not protect a resource whose entire block is removed.
- Gate: given a requirement, select validation, precondition, postcondition, or check in under 20 seconds.

### Day 5, D-8: modules

- Study objective 5 and complete subdeck 05: 13 new cards.
- Lab in your existing modular project: add one new module input and output; call a local module twice with stable `for_each` keys; pass an aliased provider explicitly; inspect `.terraform/modules` after init.
- Compare local, public registry, private registry, and Git sources. State when the module `version` argument is valid.
- Gate: draw the root-to-child value flow from input, to resource, to child output, to root output without notes.

### Day 6, D-7: state, backends, drift, and refactoring

- Study objective 6 and complete subdeck 06: 17 new cards.
- Use a disposable copy of configuration and state. Never experiment against the only copy of important state.
- Lab: inspect `state list` and `state show`; rename a resource with a `moved` block; compare with `state mv`; stop managing a harmless object with a `removed` block using `destroy = false`; create out-of-band drift and review a normal plan versus refresh-only.
- Explain remote state, backend locking, dependency lock files, and why `state push` and `force-unlock` require caution.
- Gate: for destroy, forget, rename, import, and accept drift scenarios, choose the correct operation without confusing them.

### Day 7, D-6: import, inspection, logging, first timed mock

- Study objective 7 and complete subdeck 07: 10 new cards.
- Lab: create one object outside Terraform, import it with an `import` block, inspect the plan, and test configuration generation in a scratch directory. Also perform one classic CLI import so you know the difference.
- Enable `TF_LOG` only long enough to identify a useful trace, write with `TF_LOG_PATH`, then remove or protect the log because it may contain sensitive data.
- Take full timed mock 1. Prefer CloudFluently set 1 or the KodeKloud assessment if your account exposes it.
- Gate: 75%. Review every error and every low-confidence correct answer.

### Day 8, D-5: HCP workspaces, projects, execution, and migration

- Study objective 8a, 8c, and the workspace/project portions of 8b. Complete subdeck 08: 20 new cards.
- In a free HCP Terraform organization, create a project and workspace, connect with the CLI `cloud` block, and migrate only disposable state.
- Compare local and remote execution. Confirm why an HCP remote worker cannot reach your laptop's Docker socket or private localhost services.
- Inspect the Default Project and workspace execution-mode settings.
- Gate: explain HCP workspace versus CLI workspace and project versus workspace without notes.

### Day 9, D-4: HCP collaboration and governance, second timed mock

- Hands-on HCP: create a variable set; distinguish Terraform and environment variables; inspect team access; create or inspect a run trigger; locate Explorer, health assessments, policy settings, and the private registry.
- Explain dynamic provider credentials and why OIDC-based temporary credentials are preferable to long-lived cloud keys.
- Take full timed mock 2 using an unseen set.
- Gate: 80%. HCP errors must be repaired the same day, not deferred.

### Day 10, D-3: objective sweep and adversarial recall

- Walk every line of the [official content list](https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-review-004). Mark each green, yellow, or red based on whether you can explain and demonstrate it.
- Work only yellow and red items. Use HashiCorp docs first, then a small lab.
- Answer 64 mixed cards from the supplied bank in 60 minutes. Include all cards previously rated Again or Hard.
- Build a one-page memory sheet from recall, then compare it with the [FlashGenius sheet](https://flashgenius.net/terraform-004-cheat-sheet). Correct yours from official docs, not from unsupported exam-weight claims.
- Gate: no red subobjective remains; mixed score 85%.

### Day 11, D-2: final simulation and system check

- Take full timed mock 3 in 60 minutes under exam conditions: one sitting, no notes, no search, no interruptions.
- Review for at least 90 minutes. Classify misses as knowledge, wording, command confusion, or rushing.
- Run the official exam delivery system check, confirm ID and room requirements, timezone, appointment time, network, webcam, and charger.
- Do one final pass of HCP vocabulary, variable precedence, conditions, state operations, import, and init/plan/apply flags.
- Gate: 85% and finished in 50 minutes. If below 85%, repair only the top two weak areas. Do not binge more question banks.

### Day 12, D-1: consolidation, not cramming

- Complete all due Anki reviews. No more than 30 additional marked cards.
- Recite the command matrix, variable precedence, state-operation decision rules, condition timing, sensitive/ephemeral/write-only comparison, and HCP feature map.
- Read your error log once. Do not open new courses, books, or dumps.
- Prepare the room, ID, water if permitted, alarm, and backup connectivity.
- Stop studying 6 to 8 hours before sleep. The final performance task is sleep.

## Lab safety

- Use `random`, `terraform_data`, local files, Docker, or an isolated cloud sandbox where possible.
- Before any destroy, import, state move, state removal, backend migration, or force unlock, confirm the workspace, backend, account, region, resource address, and recoverability.
- Keep your existing Week 1 to Week 3 project as reference material. Run risky state exercises in a disposable copy with disposable resources.
- Clean up cloud resources daily and verify the account or region after cleanup.

## Question workflow

For each question, use four passes:

1. Identify the objective and the exact decision being tested.
2. Commit to an answer before opening documentation.
3. Verify the behavior in an official Terraform 1.12 source.
4. Record the rule in one sentence and explain why each plausible distractor fails.

Classify misses:

- **K:** knowledge gap
- **C:** confused two related commands or features
- **W:** misread wording such as always, only, before, or after
- **R:** rushed despite knowing the rule
- **U:** unverified or ambiguous third-party key

For K and C, add or edit an Anki card and retest in 24 hours. For W and R, state the decisive word before answering the next ten questions. For U, cite the official source in the log and do not memorize the third-party key.

## Resource audit and how to use each item

| Resource | Verdict | Use during these 12 days |
|---|---|---|
| [HashiCorp certification learning path](https://developer.hashicorp.com/terraform/tutorials/certification-004) | Source of truth | Primary syllabus, official sample, review list, labs, and Terraform 1.12 references |
| [FlashGenius cheat sheet](https://flashgenius.net/terraform-004-cheat-sheet) | Useful recap, not an authority | Day 10 comparison only. Its claimed question count, passing score, and domain weights are not published by HashiCorp. It also highlights material beyond the explicit objective list, so do not let it displace tested objectives. |
| [KodeKloud course](https://learn.kodekloud.com/user/courses/hashicorp-certified-terraform-associate-004) | Potentially useful structured instruction | The supplied page requires sign-in, so its private lessons and question text could not be independently audited. Use only the sections matching a red or yellow objective and use its assessment as a timed mock if available. |
| [Reddit pass report 1](https://www.reddit.com/r/Terraform/comments/1uz9shk/passed_the_hashicorp_terraform_associate_004_exam/) | Anecdotal signal | Supports emphasis on workflow, state/backends, variables, modules, HCP, sensitive data, lock files, and CLI flags. Do not infer exam weights. |
| [Reddit pass report 2](https://www.reddit.com/r/Terraform/comments/1r579o8/passed_terraform_associate_004_some_honest/) | Anecdotal signal | Supports explanation-based learning, pattern recognition from actual CLI use, and focused HCP review. Do not treat remembered topic frequency as a blueprint. |
| [LinkedIn resource post](https://www.linkedin.com/posts/himanshu-sangshetti_terraform-hashicorp-devops-activity-7415781312768417792-SF_2/) | Directory to CloudFluently resources | The current linked practice course advertises three sets of 65 questions. Schedule one set on Days 7, 9, and 11. Do not copy its private question text into Anki. |
| [ExamPrepper](https://www.examprepper.co/exam/175) | Secondary, quality-check required | Public pages contain some useful basic scenarios but also at least one inconsistent/typo-prone module question and unclear version labeling. Use only after official and CloudFluently/KodeKloud questions, and verify every disputed key. |
| [Free-braindumps](https://free-braindumps.com/hashicorp/free-terraform-associate-004-braindumps/page-2) | Excluded | It advertises alleged exam items, which are not verifiable as official or authorized. None were copied into the deck. Officially grounded original questions are safer and more useful. |
| *Terraform in Action* | Good conceptual supplement, wrong time horizon | Do not read it cover to cover. The book predates several 004 topics. Open a specific section only when it clarifies a concept already named in the official objective list. |

## Organizer question inventory

- Official HashiCorp sample: five public sample questions. Take them cold on Day 1.
- CloudFluently through the LinkedIn post: the current public outline lists three 65-question practice sets, for 195 total. Use them as three timed mocks if your access permits.
- KodeKloud: questions are behind account access on the supplied link. Use its final assessment as a substitute mock, but do not spend a day passively completing the entire course.
- ExamPrepper: a small public multi-page bank. Treat it as supplemental because version provenance and editing quality are weaker.
- Free-braindumps: claims a large bank of alleged exam questions. Excluded from collection and memorization.
- Supplied original bank: 128 scenario questions, all mapped to official objectives and linked to HashiCorp documentation.

## Final memory matrices

### Conditions

| Construct | Main timing | Failure behavior |
|---|---|---|
| Variable `validation` | Input validation before planning proceeds | Error, blocks operation |
| `precondition` | Before the associated resource operation | Error, blocks operation |
| `postcondition` | After the resource/data result is known | Error, blocks dependent progress |
| `check` | Final validation phase | Warning, does not block the operation |

### Secret-related semantics

| Feature | Normal UI redaction | Omitted from plan/state | Defined by |
|---|---|---|---|
| `sensitive` | Yes | No | Terraform configuration |
| `ephemeral` value | Use with sensitive for redaction | Yes | Terraform configuration, with contextual restrictions |
| Write-only argument | Not readable back as a normal value | Yes after current operation | Provider schema |

### State decisions

| Intent | Preferred tool |
|---|---|
| Preview reconciliation | `terraform plan` |
| Accept remote reality into state without normal infrastructure changes | Refresh-only plan/apply |
| Rename an address reviewably | `moved` block |
| Rename an address imperatively | `terraform state mv` |
| Stop managing but keep the object reviewably | `removed` block with `destroy = false` |
| Stop managing imperatively | `terraform state rm` |
| Adopt an existing object | `import` block or `terraform import` |
| Move state to a new backend | `terraform init -migrate-state` |

### HCP feature map

| Need | Feature |
|---|---|
| Group workspaces and scope access | Projects |
| Share variables across many workspaces | Variable sets |
| Queue downstream work after a successful apply | Run triggers |
| Temporary cloud authentication | Dynamic provider credentials with OIDC |
| Organization-wide inventory and filters | Explorer |
| Drift and check monitoring | Health assessments |
| Reusable internal modules/providers | Private registry |
| Enforce rules against proposed plans | Policy sets |
| Run inside private network reachability | Agents |

## Official anchors

- [Exam overview and learning path](https://developer.hashicorp.com/terraform/tutorials/certification-004)
- [Complete objective list](https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-review-004)
- [Official sample questions](https://developer.hashicorp.com/terraform/tutorials/certification-004/associate-questions-004)
- [Terraform 1.12 language documentation](https://developer.hashicorp.com/terraform/language/v1.12.x)
- [Terraform 1.12 CLI documentation](https://developer.hashicorp.com/terraform/cli/v1.12.x)
- [HCP Terraform documentation](https://developer.hashicorp.com/terraform/cloud-docs)
