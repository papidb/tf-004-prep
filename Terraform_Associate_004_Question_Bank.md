# Terraform Associate 004 Scenario Question Bank

128 original, objective-aligned questions. Use closed-book first. Each answer cites an official HashiCorp source.

## 01 Infrastructure as Code

### T004-001 · Single choice

A team provisions identical test environments every week. Manual tickets produce inconsistent settings. Which Terraform benefit most directly addresses this?

A. Permanent cloud credentials
B. A provider-independent state format
C. Automatic elimination of every outage
D. Declarative, version-controlled configuration

<details><summary>Answer and rationale</summary>

**Answer:** Declarative, version-controlled configuration

Configuration can be reviewed, reused, and applied consistently. Terraform reduces configuration drift caused by manual repetition, but it cannot guarantee that outages never occur.

[Official source](https://developer.hashicorp.com/terraform/intro)

</details>

### T004-002 · True/False

Terraform configuration normally describes the desired end state rather than a sequence of API calls that the author must order manually.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** True

Terraform is declarative. Providers translate the desired configuration into API operations and Terraform builds a dependency graph for ordering.

[Official source](https://developer.hashicorp.com/terraform/language)

</details>

### T004-003 · Single choice

An engineer changes an instance size in code and wants to know the proposed consequences before changing production. Which IaC capability is being used?

A. Execution planning
B. Provider aliasing
C. State locking
D. Module publishing

<details><summary>Answer and rationale</summary>

**Answer:** Execution planning

A Terraform plan previews the actions needed to reconcile configuration, state, and remote objects.

[Official source](https://developer.hashicorp.com/terraform/intro/core-workflow)

</details>

### T004-004 · Multiple answer

Which two practices become easier when infrastructure is represented as code?

A. Peer review through version control
B. Keeping secrets permanently out of state
C. Avoiding all provider APIs
D. Reproducing an environment from a known revision

<details><summary>Answer and rationale</summary>

**Answer:** Peer review through version control; Reproducing an environment from a known revision

Code can be reviewed and versioned. IaC still calls provider APIs, and ordinary sensitive values can still be stored in state.

[Official source](https://developer.hashicorp.com/terraform/intro)

</details>

### T004-005 · Single choice

A company uses AWS and GitHub. Why can one Terraform workflow manage both?

A. Terraform converts both platforms into the same API
B. State replaces authentication
C. Backends install cloud SDKs
D. Providers expose each platform's API resources to Terraform

<details><summary>Answer and rationale</summary>

**Answer:** Providers expose each platform's API resources to Terraform

Terraform providers are plugins that implement resources and data sources for remote systems.

[Official source](https://developer.hashicorp.com/terraform/language/providers)

</details>

### T004-006 · True/False

Using Terraform means remote infrastructure can no longer drift from configuration.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Out-of-band changes can still create drift. Terraform detects differences during refresh/plan and proposes reconciliation.

[Official source](https://developer.hashicorp.com/terraform/language/state/purpose)

</details>

### T004-007 · Single choice

Which sequence best represents Terraform's core workflow?

A. Apply, import, format
B. Validate, publish, unlock
C. Write, plan, apply
D. Init, destroy, write

<details><summary>Answer and rationale</summary>

**Answer:** Write, plan, apply

The core workflow is write configuration, review a plan, then apply it. Initialization is a setup command used when needed.

[Official source](https://developer.hashicorp.com/terraform/intro/core-workflow)

</details>

## 02 Fundamentals and Providers

### T004-008 · Single choice

A configuration uses hashicorp/aws. Where should its source address and acceptable versions be declared?

A. backend
B. provider.aws
C. terraform.required_providers
D. locals

<details><summary>Answer and rationale</summary>

**Answer:** terraform.required_providers

The required_providers block declares each provider's local name, source address, and version constraint.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/providers/requirements)

</details>

### T004-009 · Single choice

Where are an AWS region and an alias for a second region normally configured?

A. required_providers
B. output blocks
C. provider blocks
D. the lock file

<details><summary>Answer and rationale</summary>

**Answer:** provider blocks

Provider blocks configure provider-specific settings. required_providers declares source and version requirements.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/provider)

</details>

### T004-010 · Single choice

A repository was freshly cloned and has no .terraform directory. Which command installs required provider plugins?

A. terraform validate
B. terraform init
C. terraform providers lock
D. terraform apply

<details><summary>Answer and rationale</summary>

**Answer:** terraform init

Initialization downloads providers and modules and configures the backend.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-011 · Single choice

Resources must be created in us-east-1 and eu-west-1 with the AWS provider. What is the usual pattern?

A. Two provider configurations, one with an alias
B. Two required_providers entries named aws
C. Two backend blocks
D. Two state files in the same working directory

<details><summary>Answer and rationale</summary>

**Answer:** Two provider configurations, one with an alias

Define a default provider configuration and an aliased configuration, then select the alias with the provider meta-argument.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/provider)

</details>

### T004-012 · Single choice

A resource must use the aliased provider aws.west. Which resource meta-argument selects it?

A. alias = west
B. providers = aws.west
C. provider = aws.west
D. source = aws.west

<details><summary>Answer and rationale</summary>

**Answer:** provider = aws.west

Resources select a non-default provider configuration with the provider meta-argument and an unquoted provider reference.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/provider)

</details>

### T004-013 · Multiple answer

What does .terraform.lock.hcl record?

A. Remote module version selections
B. Provider checksums
C. Selected provider versions
D. Current resource attributes

<details><summary>Answer and rationale</summary>

**Answer:** Selected provider versions; Provider checksums

The dependency lock file tracks provider selections and checksums. It does not track remote module version selections or resource state.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/files/dependency-lock)

</details>

### T004-014 · True/False

A team should usually commit .terraform.lock.hcl to version control.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** True

Committing the lock file lets future runs use reviewed provider selections and verify package checksums.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/files/dependency-lock)

</details>

### T004-015 · Single choice

The configuration permits AWS provider versions >= 5.0 and < 6.0, but the lock file selects 5.42. What does a normal terraform init prefer?

A. 5.42 if it still satisfies the constraint
B. 6.0
C. The newest 5.x version every time
D. No provider because constraints and locks conflict

<details><summary>Answer and rationale</summary>

**Answer:** 5.42 if it still satisfies the constraint

Terraform honors the existing locked selection when it remains compatible. Use init -upgrade to consider newer acceptable versions.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/files/dependency-lock)

</details>

### T004-016 · Single choice

Which command asks Terraform to disregard existing provider selections and choose newer versions allowed by the constraints?

A. terraform apply -refresh-only
B. terraform state replace-provider
C. terraform providers mirror
D. terraform init -upgrade

<details><summary>Answer and rationale</summary>

**Answer:** terraform init -upgrade

The -upgrade option ignores previous provider selections in the lock file while still obeying configured version constraints.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-017 · Single choice

Why does Terraform maintain state for a managed resource?

A. To store only comments from configuration
B. To map a configuration address to a remote object and retain needed metadata
C. To replace provider authentication
D. To guarantee that remote objects cannot change

<details><summary>Answer and rationale</summary>

**Answer:** To map a configuration address to a remote object and retain needed metadata

State binds resource instances in configuration to remote objects and stores metadata used for dependency and performance decisions.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/purpose)

</details>

### T004-018 · True/False

A value marked sensitive is necessarily absent from Terraform state.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Sensitive controls redaction in normal UI output. Unless the value is also ephemeral or a provider write-only argument, it can still be stored in plan and state.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data)

</details>

### T004-019 · Single choice

A child module should use the root module's aws.west configuration. Which module meta-argument explicitly maps it?

A. providers
B. depends_on
C. required_providers
D. provider

<details><summary>Answer and rationale</summary>

**Answer:** providers

A module call can pass provider configurations with its providers map, for example aws = aws.west.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-020 · Single choice

Which command displays the provider requirements detected across the current configuration and its modules?

A. terraform output
B. terraform show
C. terraform providers
D. terraform console

<details><summary>Answer and rationale</summary>

**Answer:** terraform providers

terraform providers reports the provider requirements of the configuration.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/providers)

</details>

### T004-021 · True/False

Provider configuration arguments may safely depend on a managed resource attribute that will be unknown until apply.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Provider configuration must be available for operations that occur before resource creation. Values should be known before apply, rather than depend on a resource created in the same run.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/provider)

</details>

## 03 Core Workflow

### T004-022 · Single choice

A working directory contains configuration but has never been initialized. Which command should run before plan or apply?

A. terraform init
B. terraform login
C. terraform state pull
D. terraform fmt

<details><summary>Answer and rationale</summary>

**Answer:** terraform init

Initialization prepares the working directory, backend, child modules, and provider plugins.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-023 · True/False

It is safe to run terraform init more than once in the same working directory.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** True

Initialization is designed to be idempotent and can be repeated when dependencies or backend settings change.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-024 · Single choice

A backend configuration changed and existing state must be copied to the new backend. Which initialization option is intended for that?

A. -backend=false
B. -upgrade
C. -get=false
D. -migrate-state

<details><summary>Answer and rationale</summary>

**Answer:** -migrate-state

terraform init -migrate-state attempts to copy existing state to the newly configured backend. -reconfigure accepts new settings without migration.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-025 · Single choice

A reusable child module needs a syntax and internal-consistency check without accessing a configured backend. Which sequence is appropriate?

A. terraform state list, then terraform fmt
B. terraform init -backend=false, then terraform validate
C. terraform import, then terraform test
D. terraform apply -refresh-only

<details><summary>Answer and rationale</summary>

**Answer:** terraform init -backend=false, then terraform validate

Validation needs installed modules/providers but not a backend. A backend-free initialization creates the environment for validate.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/validate)

</details>

### T004-026 · Multiple answer

What does terraform validate check?

A. Whether the proposed changes are acceptable
B. Whether cloud credentials can create every resource
C. Configuration syntax
D. Internal argument and reference consistency

<details><summary>Answer and rationale</summary>

**Answer:** Configuration syntax; Internal argument and reference consistency

validate checks syntax and internal consistency. It does not validate remote APIs or replace plan review.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/validate)

</details>

### T004-027 · True/False

A normal terraform plan refreshes remote object information before calculating proposed changes unless refresh is disabled.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** True

Planning reads current remote objects by default, updates Terraform's view, and compares it with configuration.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-028 · Single choice

A plan was run without -out. What kind of plan is it?

A. Saved and immutable
B. Destroy mode
C. Speculative and not guaranteed to be the exact plan later applied
D. Refresh-only

<details><summary>Answer and rationale</summary>

**Answer:** Speculative and not guaranteed to be the exact plan later applied

Without -out, plan is for review. A later apply creates a fresh plan unless given a saved plan file.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-029 · Single choice

A CI job must apply exactly the reviewed plan. Which workflow fits?

A. terraform plan -out=tfplan, then terraform apply tfplan
B. terraform show, then terraform apply -upgrade
C. terraform plan, then terraform apply -refresh-only
D. terraform validate, then terraform apply -target=all

<details><summary>Answer and rationale</summary>

**Answer:** terraform plan -out=tfplan, then terraform apply tfplan

A saved plan can be passed to apply so Terraform executes those recorded actions, subject to the plan remaining usable.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-030 · Single choice

terraform apply is run without a saved-plan argument. What happens first?

A. Terraform creates a new plan and asks for approval
B. Terraform only updates state
C. Terraform skips refresh
D. Terraform applies the last speculative plan

<details><summary>Answer and rationale</summary>

**Answer:** Terraform creates a new plan and asks for approval

Automatic plan mode creates a plan, presents it, and requests approval unless an applicable noninteractive option is used.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/apply)

</details>

### T004-031 · Single choice

Which command removes all managed objects described by the current configuration?

A. terraform fmt -recursive
B. terraform init -reconfigure
C. terraform state rm '*'
D. terraform destroy

<details><summary>Answer and rationale</summary>

**Answer:** terraform destroy

terraform destroy is a convenience alias for terraform apply -destroy. State removal alone does not destroy remote objects.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/destroy)

</details>

### T004-032 · Single choice

CI should fail if any Terraform file is not canonically formatted, without rewriting files. Which command is suitable?

A. terraform validate -json
B. terraform show -json
C. terraform plan -detailed-exitcode
D. terraform fmt -check -recursive

<details><summary>Answer and rationale</summary>

**Answer:** terraform fmt -check -recursive

fmt -check checks formatting, and -recursive includes subdirectories.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/fmt)

</details>

### T004-033 · Single choice

A team wants state to accept out-of-band changes without modifying remote resources. Which planning mode proposes only state reconciliation?

A. terraform state push
B. terraform plan -destroy
C. terraform plan -target
D. terraform plan -refresh-only

<details><summary>Answer and rationale</summary>

**Answer:** terraform plan -refresh-only

Refresh-only mode proposes updates to state and root outputs to match remote objects without planning normal infrastructure changes.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-034 · Single choice

One unhealthy instance should be replaced even though its arguments have not changed. Which planning option expresses that intent?

A. -replace=ADDRESS
B. -refresh=false
C. -target=ADDRESS
D. -lock=false

<details><summary>Answer and rationale</summary>

**Answer:** -replace=ADDRESS

The -replace option requests replacement of a specific resource instance in the plan.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-035 · True/False

Routine use of -target is recommended as the normal way to apply each resource separately.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

Resource targeting is intended for exceptional recovery or troubleshooting. Normal plans should consider the whole configuration and dependency graph.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-036 · Single choice

A CI job uses terraform plan -detailed-exitcode. Which exit code means the plan succeeded and contains changes?

A. 1
B. 3
C. 2
D. 0

<details><summary>Answer and rationale</summary>

**Answer:** 2

With detailed exit codes, 0 means success with no changes, 1 means error, and 2 means success with changes.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-037 · Single choice

What is the most direct effect of -auto-approve in automatic apply mode?

A. It validates cloud permissions
B. It saves the plan to disk
C. It disables state locking
D. It skips the interactive approval prompt

<details><summary>Answer and rationale</summary>

**Answer:** It skips the interactive approval prompt

-auto-approve bypasses interactive confirmation. It does not change locking, authentication, or create a plan file.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/apply)

</details>

## 04 Configuration

### T004-038 · Single choice

Configuration declares resource "aws_instance" "web". What is its address when neither count nor for_each is used?

A. resource.aws_instance.web
B. module.aws_instance.web
C. aws_instance.web
D. aws.web.instance

<details><summary>Answer and rationale</summary>

**Answer:** aws_instance.web

A managed resource address combines resource type and local name.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/state/resource-addressing)

</details>

### T004-039 · Single choice

A team needs the ID of an existing VPC without asking Terraform to manage its lifecycle. Which block type fits?

A. resource
B. data
C. terraform
D. moved

<details><summary>Answer and rationale</summary>

**Answer:** data

A data source reads information from a provider without declaring that Terraform manages the remote object's lifecycle.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/data-sources)

</details>

### T004-040 · Single choice

A subnet argument uses aws_vpc.main.id. What dependency behavior does Terraform infer?

A. A manual depends_on is always required
B. No dependency because references are only strings
C. The subnet must exist first
D. The VPC must be handled before the subnet

<details><summary>Answer and rationale</summary>

**Answer:** The VPC must be handled before the subnet

A resource reference creates an implicit dependency that Terraform uses to order operations.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/references)

</details>

### T004-041 · Single choice

Two resources have a behavioral dependency but exchange no data. Which meta-argument can declare it explicitly?

A. lifecycle.ignore_changes
B. provider
C. count
D. depends_on

<details><summary>Answer and rationale</summary>

**Answer:** depends_on

depends_on records a dependency Terraform cannot infer from expression references. Use it only when a real hidden dependency exists.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/depends_on)

</details>

### T004-042 · Single choice

Instances created with count need the second instance's address. Which syntax is correct?

A. aws_instance.web[1]
B. aws_instance.web.second
C. aws_instance.web[2]
D. aws_instance.web["1"]

<details><summary>Answer and rationale</summary>

**Answer:** aws_instance.web[1]

count instances use zero-based numeric indices.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/count)

</details>

### T004-043 · Single choice

A resource uses for_each = {blue = ..., green = ...}. How is the blue instance addressed?

A. resource_type.name["blue"]
B. resource_type.name.blue.value
C. resource_type.name[0]
D. resource_type.blue

<details><summary>Answer and rationale</summary>

**Answer:** resource_type.name["blue"]

for_each instances use string keys in their addresses.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/for_each)

</details>

### T004-044 · Single choice

Stable server names may be added and removed independently. Which repetition mechanism usually avoids index shifting?

A. a provider alias
B. count based on list length
C. for_each with stable keys
D. a dynamic block

<details><summary>Answer and rationale</summary>

**Answer:** for_each with stable keys

Stable map or set keys give each instance an identity that does not depend on list position.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/for_each)

</details>

### T004-045 · Single choice

Which expression chooses "large" only when var.environment equals "prod"?

A. var.environment && "large"
B. var.environment == "prod" ? "large" : "small"
C. if var.environment then "large"
D. choose(var.environment, "large")

<details><summary>Answer and rationale</summary>

**Answer:** var.environment == "prod" ? "large" : "small"

Terraform conditional expressions use condition ? true_value : false_value.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/conditionals)

</details>

### T004-046 · Single choice

Repeated nested blocks must be generated from a collection inside a resource. Which construct is intended for that?

A. output block
B. dynamic block
C. locals block
D. terraform block

<details><summary>Answer and rationale</summary>

**Answer:** dynamic block

Dynamic blocks construct repeatable nested blocks. count and for_each on a resource repeat the resource itself.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/dynamic-blocks)

</details>

### T004-047 · Single choice

An expression is repeated across several resources but is not an input from callers. Where can it be named once?

A. locals
B. variable
C. required_providers
D. output

<details><summary>Answer and rationale</summary>

**Answer:** locals

Local values name expressions for reuse within a module. Input variables are part of the module's caller interface.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/locals)

</details>

### T004-048 · Single choice

No value is supplied for an input variable that has a default. What value does Terraform use?

A. null in every case
B. The declared default
C. An empty string
D. The provider's default

<details><summary>Answer and rationale</summary>

**Answer:** The declared default

A variable default makes the input optional and is used when no higher-precedence assignment supplies a value.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/variable)

</details>

### T004-049 · Single choice

The same variable is set by TF_VAR_region and terraform.tfvars. Which value wins in a local CLI run?

A. terraform.tfvars
B. The provider region
C. TF_VAR_region
D. The variable default

<details><summary>Answer and rationale</summary>

**Answer:** terraform.tfvars

Environment variables have lower precedence than terraform.tfvars and auto-loaded variable files.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/variables)

</details>

### T004-050 · Single choice

The same variable appears in terraform.tfvars and prod.auto.tfvars. Which takes precedence?

A. terraform.tfvars
B. prod.auto.tfvars
C. Terraform reports a duplicate-definition error
D. Whichever file is larger

<details><summary>Answer and rationale</summary>

**Answer:** prod.auto.tfvars

Automatically loaded *.auto.tfvars files are processed after terraform.tfvars; later sources have higher precedence.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/variables)

</details>

### T004-051 · Single choice

A CLI run uses -var-file=base.tfvars and then -var-file=prod.tfvars, both setting instance_type. Which wins?

A. base.tfvars
B. The variable default
C. terraform.tfvars regardless
D. prod.tfvars

<details><summary>Answer and rationale</summary>

**Answer:** prod.tfvars

CLI variable options are processed in order, and the later assignment takes precedence.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/variables)

</details>

### T004-052 · Single choice

In local CLI execution, which listed source normally has the highest precedence?

A. terraform.tfvars
B. TF_VAR_name
C. The last -var or -var-file argument
D. The variable default

<details><summary>Answer and rationale</summary>

**Answer:** The last -var or -var-file argument

CLI options have higher precedence than automatically loaded files, environment variables, and defaults. HCP priority variable sets are a separate HCP case.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/variables)

</details>

### T004-053 · Single choice

A variable has type set(string) and receives duplicate values. What collection property should the author expect?

A. Values become map keys with null values
B. Duplicates and original ordering are preserved
C. Duplicates are removed and ordering is not significant
D. The input always fails conversion

<details><summary>Answer and rationale</summary>

**Answer:** Duplicates are removed and ordering is not significant

Sets contain unique elements and do not preserve meaningful ordering.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/type-constraints)

</details>

### T004-054 · Single choice

A module input requires object({name=string, ports=set(number)}). What does this provide over type = any?

A. A documented shape and validation by Terraform's type system
B. Automatic provider installation
C. A guaranteed non-null value
D. State encryption

<details><summary>Answer and rationale</summary>

**Answer:** A documented shape and validation by Terraform's type system

Specific type constraints define the accepted structure and permit safe attribute access. Nullability is controlled separately.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/type-constraints)

</details>

### T004-055 · Single choice

A root output contains a password and is marked sensitive = true. What does Terraform do?

A. Omits it from state
B. Prevents providers from receiving it
C. Redacts it in normal CLI/UI output but may store it in state
D. Hashes it before passing it to modules

<details><summary>Answer and rationale</summary>

**Answer:** Redacts it in normal CLI/UI output but may store it in state

Sensitive is a display-protection mechanism, not state omission or encryption.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data)

</details>

### T004-056 · Single choice

Operators want Terraform runs to use scoped AWS credentials that expire instead of distributing long-lived keys to every engineer. Which Vault pattern addresses this?

A. Use terraform state rm after every run
B. Store keys in the provider dependency lock file
C. Use a Vault secrets engine to generate short-lived dynamic credentials
D. Commit static keys in a sensitive variable

<details><summary>Answer and rationale</summary>

**Answer:** Use a Vault secrets engine to generate short-lived dynamic credentials

Vault can generate scoped, leased credentials for a run, reducing the number and lifetime of static secrets held by Terraform operators.

[Official source](https://developer.hashicorp.com/terraform/tutorials/secrets/secrets-vault)

</details>

### T004-057 · Single choice

A resource name must be unique, but replacement should be created before the old object is destroyed. Which lifecycle rule expresses that ordering?

A. ignore_changes
B. replace_triggered_by
C. prevent_destroy
D. create_before_destroy

<details><summary>Answer and rationale</summary>

**Answer:** create_before_destroy

create_before_destroy reverses the default replacement order. Unique-name constraints may require a naming strategy that permits both objects temporarily.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/lifecycle)

</details>

### T004-058 · True/False

prevent_destroy protects a remote object if its resource block is removed entirely from configuration.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

The rule is present only while the resource block remains in configuration. Removing the block removes the rule, so the plan can propose destruction.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/lifecycle)

</details>

### T004-059 · Single choice

A platform automatically updates a resource tag, and Terraform should not revert that tag while still managing the resource. Which rule may be appropriate?

A. replace_triggered_by
B. prevent_destroy
C. ignore_changes for that attribute
D. create_before_destroy

<details><summary>Answer and rationale</summary>

**Answer:** ignore_changes for that attribute

ignore_changes tells Terraform to ignore selected attribute differences during update planning after creation.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/lifecycle)

</details>

### T004-060 · Single choice

A resource should be replaced whenever another managed resource is replaced, even though no argument value changes. Which lifecycle feature is intended?

A. depends_on
B. ignore_changes
C. precondition
D. replace_triggered_by

<details><summary>Answer and rationale</summary>

**Answer:** replace_triggered_by

replace_triggered_by adds replacement triggers based on managed resource or attribute changes. depends_on affects ordering, not replacement by itself.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/lifecycle)

</details>

### T004-061 · True/False

Lifecycle rule arguments can freely use values that are unknown until apply.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

Terraform processes lifecycle settings early, so only literal values can be used for these rules.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/lifecycle)

</details>

### T004-062 · Single choice

An input variable must reject any CIDR that is not a /32 before planning proceeds. Which construct belongs in the variable block?

A. check
B. depends_on
C. validation
D. postcondition

<details><summary>Answer and rationale</summary>

**Answer:** validation

Custom variable validation checks an input value and returns an error when its condition is false.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/validate)

</details>

### T004-063 · Single choice

A resource must not be created unless an AMI architecture matches the requested instance architecture. Which condition is best placed before the resource operation?

A. output sensitive
B. check
C. precondition
D. postcondition

<details><summary>Answer and rationale</summary>

**Answer:** precondition

A precondition is evaluated before the resource operation and can block planning or applying when its requirement is false.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/validate)

</details>

### T004-064 · Single choice

After creating a service, its returned endpoint must use HTTPS or downstream resources must not proceed. Which construct fits?

A. provider alias
B. variable validation
C. postcondition
D. ignore_changes

<details><summary>Answer and rationale</summary>

**Answer:** postcondition

A postcondition validates a resource or data-source result after planning/applying/read and can prevent dependent operations when it fails.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/validate)

</details>

### T004-065 · Single choice

A production health assertion should run at the end of plan/apply but report a warning rather than block infrastructure changes. Which construct fits?

A. postcondition
B. variable validation
C. precondition
D. check block

<details><summary>Answer and rationale</summary>

**Answer:** check block

Check blocks run as the final validation step and report warnings without blocking the operation.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/validate)

</details>

### T004-066 · Single choice

A short-lived token must be available during a run but omitted from state and plan. Which variable setting introduced for this purpose is appropriate?

A. description = "secret"
B. sensitive = true only
C. nullable = false
D. ephemeral = true

<details><summary>Answer and rationale</summary>

**Answer:** ephemeral = true

Ephemeral values are available during an operation but omitted from state and plan files. They are commonly also marked sensitive to redact display.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data/ephemeral)

</details>

### T004-067 · Single choice

A provider resource exposes password_wo. What distinguishes a write-only argument?

A. It can only be set through TF_VAR
B. Terraform encrypts and persists it
C. Terraform passes it for the current operation and does not persist it in state or plan
D. It is readable from terraform output

<details><summary>Answer and rationale</summary>

**Answer:** Terraform passes it for the current operation and does not persist it in state or plan

Write-only arguments are provider-defined inputs used for the current operation and then discarded by Terraform.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data/ephemeral)

</details>

### T004-068 · True/False

Every provider argument automatically has a write-only variant in Terraform 1.12.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

Providers must explicitly implement write-only arguments. Their availability and names are provider-specific.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data/ephemeral)

</details>

## 05 Modules

### T004-069 · Single choice

A child module lives in ./modules/network. What source syntax should the root module use?

A. source = "modules::network"
B. provider = "./modules/network"
C. version = "./modules/network"
D. source = "./modules/network"

<details><summary>Answer and rationale</summary>

**Answer:** source = "./modules/network"

Local module sources use relative paths beginning with ./ or ../.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-070 · Single choice

Which public registry source address identifies the AWS VPC module from the terraform-aws-modules namespace?

A. registry.terraform.io/aws/vpc
B. github.com/terraform-aws-modules/vpc/aws
C. hashicorp/aws/vpc
D. terraform-aws-modules/vpc/aws

<details><summary>Answer and rationale</summary>

**Answer:** terraform-aws-modules/vpc/aws

Public registry module sources use namespace/name/provider.

[Official source](https://developer.hashicorp.com/terraform/registry/modules/use)

</details>

### T004-071 · True/False

The version argument in a module block can constrain any Git repository module source.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

The module version argument applies to modules installed from a registry. Non-registry sources select versions through their source-specific mechanism, such as a Git ref.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-072 · Single choice

A registry module is constrained to ~> 3.2.1. Which release is allowed?

A. 3.1.9
B. 3.2.9
C. 4.0.0
D. 3.3.0

<details><summary>Answer and rationale</summary>

**Answer:** 3.2.9

~> 3.2.1 allows patch-level updates in the 3.2 series but not 3.3.0.

[Official source](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)

</details>

### T004-073 · Single choice

A root module needs a child module's subnet_ids output. Which reference is correct?

A. var.network.subnet_ids
B. data.module.network.subnet_ids
C. module.network.subnet_ids
D. network.output.subnet_ids

<details><summary>Answer and rationale</summary>

**Answer:** module.network.subnet_ids

Child module outputs are referenced as module.<call-name>.<output-name>.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/references)

</details>

### T004-074 · True/False

A child module can directly refer to an arbitrary resource in its caller without that value being passed as an input.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

Modules have scope boundaries. A child receives values through input variables and exposes selected values through outputs.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/modules/develop/composition)

</details>

### T004-075 · Single choice

A new remote module call was added to configuration. Which command retrieves it into the working directory?

A. terraform validate
B. terraform state pull
C. terraform init
D. terraform output

<details><summary>Answer and rationale</summary>

**Answer:** terraform init

Initialization installs or updates referenced child modules according to the module source and options.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-076 · Single choice

Where does Terraform normally cache downloaded child modules within a working directory?

A. terraform.tfstate/modules
B. modules.lock
C. .terraform.lock.hcl/modules
D. .terraform/modules

<details><summary>Answer and rationale</summary>

**Answer:** .terraform/modules

Installed modules are cached under the working directory's .terraform directory. The dependency lock file does not lock module versions.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-077 · Single choice

Ten similar application stacks should be instantiated from one module using stable names. Which module meta-argument is suitable?

A. for_each
B. dynamic
C. backend
D. lifecycle

<details><summary>Answer and rationale</summary>

**Answer:** for_each

Module calls support count or for_each, with stable keys often making for_each preferable.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-078 · Single choice

A child module should use aws.eu instead of the root's default aws configuration. What belongs on the module call?

A. providers = { aws = aws.eu }
B. alias = "eu"
C. provider = aws.eu
D. required_providers = { aws = aws.eu }

<details><summary>Answer and rationale</summary>

**Answer:** providers = { aws = aws.eu }

The module providers map overrides which root provider configurations satisfy the child's provider configuration names.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-079 · Multiple answer

Which elements form a clean module interface?

A. Input variables
B. Direct access to caller-local resources
C. Output values
D. A backend block required in every child

<details><summary>Answer and rationale</summary>

**Answer:** Input variables; Output values

Inputs and outputs define module boundaries. Child modules should not configure a backend, and they cannot directly reach caller-local objects.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/modules/develop/composition)

</details>

### T004-080 · Single choice

A team wants a module discoverable with versioned releases and documentation inside its organization. Which HCP feature fits?

A. State locking
B. Run trigger
C. Explorer saved view
D. Private registry

<details><summary>Answer and rationale</summary>

**Answer:** Private registry

The private registry provides organization-scoped modules and providers with version discovery and documentation.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/registry)

</details>

### T004-081 · True/False

A module call can use both count and for_each at the same time.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

A module call may use count or for_each, but the two repetition meta-arguments are mutually exclusive.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

## 06 State and Backends

### T004-082 · Single choice

What is Terraform state primarily for?

A. Replacing configuration files
B. Binding resource instances to remote objects and retaining metadata
C. Storing provider binaries
D. Encrypting every secret

<details><summary>Answer and rationale</summary>

**Answer:** Binding resource instances to remote objects and retaining metadata

State records object bindings and attributes Terraform needs to plan and apply changes.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/purpose)

</details>

### T004-083 · Single choice

Several engineers run Terraform against the same environment. What is the main benefit of a shared remote backend?

A. Provider credential creation
B. Automatic module versioning
C. Elimination of configuration drift
D. Shared current state and, when supported, locking

<details><summary>Answer and rationale</summary>

**Answer:** Shared current state and, when supported, locking

Remote state centralizes access. Many backends also provide locking, but capabilities vary by backend.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/backends)

</details>

### T004-084 · True/False

Every Terraform backend supports state locking.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

Locking behavior depends on backend capabilities. Terraform automatically locks for supported operations when the backend provides it.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/locking)

</details>

### T004-085 · Single choice

A state lock remains after a crashed run. What should happen before terraform force-unlock is used?

A. Verify no active operation owns the lock and use the exact lock ID
B. Remove .terraform.lock.hcl
C. Delete the entire backend
D. Run apply with -lock=false

<details><summary>Answer and rationale</summary>

**Answer:** Verify no active operation owns the lock and use the exact lock ID

Force-unlocking an active lock risks concurrent state writes. The dependency lock file is unrelated to state locking.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/locking)

</details>

### T004-086 · Single choice

A resource block is renamed from aws_instance.web to aws_instance.app with no remote replacement desired. What is the configuration-driven refactor mechanism?

A. A moved block
B. An import block
C. prevent_destroy
D. terraform taint

<details><summary>Answer and rationale</summary>

**Answer:** A moved block

A moved block tells Terraform the old and new addresses so it can update the binding without destroying the object.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/moved)

</details>

### T004-087 · Single choice

For an imperative one-time rename of a state address, which command is designed for the task?

A. terraform state rm
B. terraform fmt
C. terraform state mv
D. terraform import

<details><summary>Answer and rationale</summary>

**Answer:** terraform state mv

state mv changes resource addresses in state. moved blocks are the declarative, reviewable alternative for refactors.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/mv)

</details>

### T004-088 · Single choice

Terraform should stop managing an object but leave the remote object intact. Which configuration construct can express that intent reviewably?

A. lifecycle prevent_destroy only
B. removed block with destroy = false
C. moved block
D. import block

<details><summary>Answer and rationale</summary>

**Answer:** removed block with destroy = false

A removed block can remove the object from state without destroying it when its lifecycle specifies destroy = false.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/removed)

</details>

### T004-089 · Single choice

What does terraform state rm do to the selected remote object?

A. It imports it under a new address
B. It destroys it immediately
C. It only hides it from terraform show
D. It forgets the binding but does not destroy the remote object

<details><summary>Answer and rationale</summary>

**Answer:** It forgets the binding but does not destroy the remote object

After state rm, Terraform no longer manages that object. A later plan may propose creating a replacement if configuration still declares it.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/rm)

</details>

### T004-090 · Single choice

An operator changes a security group rule in the cloud console. What usually exposes the difference to Terraform?

A. terraform fmt
B. The provider lock file
C. A module version constraint
D. A refresh performed during plan or apply

<details><summary>Answer and rationale</summary>

**Answer:** A refresh performed during plan or apply

Terraform reads remote objects during normal planning and compares refreshed data with configuration and prior state.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/purpose)

</details>

### T004-091 · Single choice

The out-of-band security group change is intentional and configuration will be updated later. Which mode can first record the remote reality in state without changing infrastructure?

A. apply -destroy
B. state rm
C. apply -refresh-only
D. init -migrate-state

<details><summary>Answer and rationale</summary>

**Answer:** apply -refresh-only

Refresh-only apply confirms and writes state/output updates based on remote objects without normal create/update/destroy actions.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-092 · True/False

Backend credentials hard-coded in backend configuration can be copied into .terraform metadata and plan files.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** True

HashiCorp recommends environment variables or backend-specific credential mechanisms because backend configuration values can be persisted in local metadata and plan files.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/backend)

</details>

### T004-093 · Single choice

A local backend is changed to S3 and the existing state must remain associated with the same resources. Which command begins migration?

A. terraform state push without initialization
B. terraform init -migrate-state
C. terraform apply -replace
D. terraform providers lock

<details><summary>Answer and rationale</summary>

**Answer:** terraform init -migrate-state

Backend migration is handled during reinitialization with -migrate-state.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-094 · Single choice

Which file should never be confused with state even though its name contains 'lock'?

A. .terraform/environment
B. .terraform.lock.hcl
C. terraform.tfstate.backup
D. terraform.tfstate

<details><summary>Answer and rationale</summary>

**Answer:** .terraform.lock.hcl

The dependency lock file selects providers. A state lock is a backend coordination mechanism, not this file.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/files/dependency-lock)

</details>

### T004-095 · Single choice

Why is terraform state push considered dangerous?

A. It disables locking permanently
B. It installs untrusted providers
C. It always destroys resources
D. It can overwrite remote state with a supplied snapshot

<details><summary>Answer and rationale</summary>

**Answer:** It can overwrite remote state with a supplied snapshot

state push is a low-level recovery command. Incorrect state can sever or corrupt Terraform's object bindings.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/push)

</details>

### T004-096 · True/False

A local state file can contain sensitive values even if no output block prints them.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** True

State stores resource attributes needed by Terraform, including values that may be sensitive. Protect state at rest and in transit.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/sensitive-data)

</details>

### T004-097 · Single choice

A configuration uses terraform_remote_state only to read one output from another state. What access risk remains?

A. Terraform deletes non-output fields
B. The source state becomes local
C. The reader must be able to access the full state snapshot
D. The reader can only ever access that single output

<details><summary>Answer and rationale</summary>

**Answer:** The reader must be able to access the full state snapshot

Although only root outputs are exposed in expressions, credentials for terraform_remote_state generally grant access to the complete state snapshot.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/remote-state-data)

</details>

### T004-098 · Single choice

Within HCP Terraform, which data source is recommended for sharing outputs without granting full state access?

A. external
B. terraform_remote_state
C. tfe_outputs
D. http

<details><summary>Answer and rationale</summary>

**Answer:** tfe_outputs

HashiCorp recommends tfe_outputs because it can provide output access without the broader state-snapshot access required by terraform_remote_state.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/state)

</details>

## 07 Import Inspection Logging

### T004-099 · Single choice

An existing cloud object must become associated with aws_instance.legacy using the imperative CLI workflow. Which command is central?

A. terraform apply -replace=aws_instance.legacy
B. terraform state mv <remote-id> aws_instance.legacy
C. terraform import aws_instance.legacy <remote-id>
D. terraform output aws_instance.legacy

<details><summary>Answer and rationale</summary>

**Answer:** terraform import aws_instance.legacy <remote-id>

terraform import associates an existing remote object with a resource address in state.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/import)

</details>

### T004-100 · True/False

The classic terraform import command automatically generates a complete, production-ready resource block.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

The CLI import command imports into state and expects a destination resource block. Configuration generation is available through the import-block planning workflow, and generated configuration still needs review.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/import)

</details>

### T004-101 · Single choice

A reviewable import should be proposed in configuration and executed during apply. Which block expresses it?

A. import
B. removed
C. moved
D. backend

<details><summary>Answer and rationale</summary>

**Answer:** import

Import blocks make import intent part of configuration and the normal plan/apply workflow.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/import)

</details>

### T004-102 · Single choice

An import block exists for an object with no resource block. Which plan option can produce a starting resource configuration file?

A. -generate-config-out=PATH
B. -chdir=PATH
C. -out=PATH
D. -json=PATH

<details><summary>Answer and rationale</summary>

**Answer:** -generate-config-out=PATH

terraform plan can generate configuration for import targets into a new file. The result should be reviewed and refined.

[Official source](https://developer.hashicorp.com/terraform/language/import/generating-configuration)

</details>

### T004-103 · Single choice

Which command lists resource addresses currently recorded in state?

A. terraform state list
B. terraform show -json only
C. terraform providers
D. terraform output

<details><summary>Answer and rationale</summary>

**Answer:** terraform state list

state list prints the addresses of resources in the current state.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/list)

</details>

### T004-104 · Single choice

Which command displays attributes for one resource instance in state?

A. terraform validate ADDRESS
B. terraform state show ADDRESS
C. terraform console ADDRESS
D. terraform output ADDRESS

<details><summary>Answer and rationale</summary>

**Answer:** terraform state show ADDRESS

state show presents the attributes stored for a single address.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/show)

</details>

### T004-105 · Single choice

A saved plan file named tfplan needs human-readable inspection. Which command is appropriate?

A. terraform output tfplan
B. terraform show tfplan
C. terraform state show tfplan
D. terraform plan tfplan

<details><summary>Answer and rationale</summary>

**Answer:** terraform show tfplan

terraform show displays a state snapshot or saved plan in human-readable form.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/show)

</details>

### T004-106 · True/False

terraform show -json can expose sensitive values in plain text, so its output must be protected.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** True

Machine-readable plan/state output includes values needed by tooling and can display sensitive data. Treat it as sensitive material.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/show)

</details>

### T004-107 · Single choice

Terraform CLI debugging must be enabled for one command. Which environment variable controls the core log level?

A. TF_VAR_LOG
B. TF_LOG
C. TF_STATE_LOG
D. TERRAFORM_DEBUG

<details><summary>Answer and rationale</summary>

**Answer:** TF_LOG

TF_LOG accepts levels such as TRACE, DEBUG, INFO, WARN, or ERROR. Disable it afterward to avoid noisy or sensitive logs.

[Official source](https://developer.hashicorp.com/terraform/internals/v1.12.x/debugging)

</details>

### T004-108 · Single choice

TF_LOG is set and logs should be written to a file as well as controlled by the logging subsystem. Which variable specifies the path?

A. TF_WORKSPACE
B. TF_LOG_PATH
C. TF_DATA_DIR
D. TF_CLI_CONFIG_FILE

<details><summary>Answer and rationale</summary>

**Answer:** TF_LOG_PATH

TF_LOG_PATH names the log file and takes effect when logging is enabled. Logs can contain sensitive information.

[Official source](https://developer.hashicorp.com/terraform/internals/v1.12.x/debugging)

</details>

## 08 HCP Terraform

### T004-109 · Single choice

What does an HCP Terraform workspace normally contain and manage?

A. A collection of infrastructure with its configuration, state, variables, and runs
B. Only a CLI workspace name
C. A single resource instance
D. One provider binary

<details><summary>Answer and rationale</summary>

**Answer:** A collection of infrastructure with its configuration, state, variables, and runs

HCP workspaces separate infrastructure collections and keep the data and run history associated with each collection.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)

</details>

### T004-110 · True/False

HCP Terraform workspaces and Terraform CLI workspaces are the same feature with identical behavior.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

They are distinct. HCP workspaces are independently configured infrastructure units; CLI workspaces are alternate state instances within one working directory.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)

</details>

### T004-111 · Single choice

An HCP workspace uses local execution mode. Where do plan and apply execute?

A. Inside the private registry
B. On every team member's machine
C. In HCP disposable workers
D. On the operator's local machine while HCP stores state

<details><summary>Answer and rationale</summary>

**Answer:** On the operator's local machine while HCP stores state

Local execution mode uses HCP Terraform primarily as a remote state backend. Remote mode executes runs on HCP infrastructure.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/remote-operations)

</details>

### T004-112 · Multiple answer

Which features depend on remote operations rather than local execution mode?

A. Cost estimation
B. Local terraform fmt
C. Sentinel policy checks
D. Run notifications

<details><summary>Answer and rationale</summary>

**Answer:** Sentinel policy checks; Cost estimation; Run notifications

HCP run features such as policy checks, cost estimation, and notifications are associated with remote execution. fmt remains a local CLI operation.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/remote-operations)

</details>

### T004-113 · Single choice

What is the main purpose of an HCP Terraform project?

A. Replace every workspace with one state file
B. Store provider binaries locally
C. Group workspaces and stacks and scope permissions/settings
D. Create CLI aliases

<details><summary>Answer and rationale</summary>

**Answer:** Group workspaces and stacks and scope permissions/settings

Projects organize workspaces and Stacks and provide an administrative and permission boundary.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/projects)

</details>

### T004-114 · True/False

An HCP Terraform workspace can belong to several projects simultaneously.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

Every workspace and Stack belongs to exactly one project.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/projects)

</details>

### T004-115 · Single choice

An organization has not created any projects. Where are new workspaces placed?

A. No project
B. The private registry
C. Default Project
D. A CLI workspace

<details><summary>Answer and rationale</summary>

**Answer:** Default Project

Every organization has a Default Project, which cannot be deleted.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/projects)

</details>

### T004-116 · Single choice

The same cloud region and tag values must be shared by 30 workspaces. Which HCP feature is designed for this?

A. Change request
B. Explorer view
C. Run trigger
D. Variable set

<details><summary>Answer and rationale</summary>

**Answer:** Variable set

Variable sets allow reusable Terraform and environment variables to be applied across selected projects or workspaces, or globally.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/variables/managing-variables)

</details>

### T004-117 · Single choice

A priority variable set and a workspace variable both set region. Which value wins?

A. Whichever was created first
B. The workspace value
C. Terraform fails with a conflict
D. The priority variable-set value

<details><summary>Answer and rationale</summary>

**Answer:** The priority variable-set value

Priority variable sets override values at more specific scopes, including workspace variables and run-specific inputs.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/variables/managing-variables)

</details>

### T004-118 · Single choice

A VCS-connected workspace detects a commit to its configured branch. What workflow can HCP Terraform initiate?

A. Queue a speculative or normal run based on workspace settings
B. Publish a provider automatically
C. Force-unlock every workspace
D. Rewrite the Git history

<details><summary>Answer and rationale</summary>

**Answer:** Queue a speculative or normal run based on workspace settings

The VCS-driven workflow connects repository changes to HCP runs, subject to workspace trigger and auto-apply settings.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/vcs)

</details>

### T004-119 · Single choice

Terraform 1.12 configuration should integrate directly with HCP Terraform from the CLI. Which top-level block is intended?

A. remote_state
B. cloud
C. login
D. hcp

<details><summary>Answer and rationale</summary>

**Answer:** cloud

The cloud block configures CLI integration with HCP Terraform, including organization and workspace selection.

[Official source](https://developer.hashicorp.com/terraform/cli/cloud/settings)

</details>

### T004-120 · Single choice

A local state is being migrated to HCP Terraform. Which preliminary action reduces the risk of concurrent state changes?

A. Stop other Terraform operations before initializing the migration
B. Remove all provider constraints
C. Delete local state first
D. Disable locking

<details><summary>Answer and rationale</summary>

**Answer:** Stop other Terraform operations before initializing the migration

Migration guidance recommends preventing concurrent runs, authenticating, configuring the cloud integration, and then initializing/migrating carefully.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/migrate)

</details>

### T004-121 · Single choice

Workspace networking applies successfully. An application workspace should then queue a run. Which feature models this relationship?

A. Variable set
B. Explorer
C. Private registry
D. Run trigger

<details><summary>Answer and rationale</summary>

**Answer:** Run trigger

A run trigger connects a source workspace to a target so a successful source apply queues a target run.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings/run-triggers)

</details>

### T004-122 · True/False

A run trigger automatically applies the target workspace in all cases.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

A successful source apply queues a target run. Auto-application depends on the target's separate run-trigger auto-apply behavior and settings.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings/run-triggers)

</details>

### T004-123 · Single choice

A team wants HCP Terraform runs to obtain short-lived cloud credentials without storing long-lived static keys. Which mechanism fits?

A. A sensitive workspace variable containing a permanent key
B. Dynamic provider credentials using OIDC
C. terraform_remote_state
D. The dependency lock file

<details><summary>Answer and rationale</summary>

**Answer:** Dynamic provider credentials using OIDC

HCP authenticates a run to the cloud through OIDC and the cloud returns temporary, narrowly scoped credentials.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials)

</details>

### T004-124 · Single choice

Security rules must evaluate the proposed plan before apply across selected projects. Which HCP organizational construct attaches those rules?

A. Variable set
B. Run trigger
C. Policy set
D. Workspace tag only

<details><summary>Answer and rationale</summary>

**Answer:** Policy set

Policy sets group policy rules and can be attached globally or to selected projects/workspaces for plan enforcement.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/policy-enforcement)

</details>

### T004-125 · Single choice

What is the difference between drift detection and continuous validation in HCP health assessments?

A. Drift detection formats code; continuous validation installs providers
B. They are identical labels
C. Continuous validation changes resources automatically
D. Drift detection compares real infrastructure with state; continuous validation evaluates checks against current data

<details><summary>Answer and rationale</summary>

**Answer:** Drift detection compares real infrastructure with state; continuous validation evaluates checks against current data

Health assessments distinguish state drift from ongoing check-block assertions. Assessments report health and do not inherently mutate infrastructure.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/health)

</details>

### T004-126 · Single choice

An administrator needs an organization-wide view of workspaces with drifted state or failed checks. Which feature is designed for this?

A. Private registry
B. Run trigger
C. Explorer
D. CLI workspace select

<details><summary>Answer and rationale</summary>

**Answer:** Explorer

Explorer queries and summarizes workspace, module, provider, version, drift, and check information across the organization.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/explorer)

</details>

### T004-127 · True/False

An Explorer saved view stores a frozen copy of the current results forever.

A. False
B. True

<details><summary>Answer and rationale</summary>

**Answer:** False

A saved view stores the query. Results update as organization data changes.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/explorer)

</details>

### T004-128 · Single choice

Remote runs must reach resources accessible only inside a private network. Which HCP capability is commonly used?

A. CLI workspaces
B. terraform fmt
C. The public module registry
D. Terraform agents

<details><summary>Answer and rationale</summary>

**Answer:** Terraform agents

Agents execute HCP Terraform work in customer-controlled network environments while retaining the HCP workflow.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/agents)

</details>

