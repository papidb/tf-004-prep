# Terraform Associate 004 Scenario Question Bank

128 original, objective-aligned questions. Use closed-book first. Each answer cites an official HashiCorp source.

## 01 Infrastructure as Code

### T004-001 · Single choice

A team provisions identical test environments every week. Manual tickets produce inconsistent settings. Which Terraform benefit most directly addresses this?

A. Declarative, version-controlled configuration
B. Automatic elimination of every outage
C. A provider-independent state format
D. Permanent cloud credentials

<details><summary>Answer and rationale</summary>

**Answer:** Declarative, version-controlled configuration

Configuration can be reviewed, reused, and applied consistently. Terraform reduces configuration drift caused by manual repetition, but it cannot guarantee that outages never occur.

[Official source](https://developer.hashicorp.com/terraform/intro)

</details>

### T004-002 · True/False

Terraform configuration normally describes the desired end state rather than a sequence of API calls that the author must order manually.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** True

Terraform is declarative. Providers translate the desired configuration into API operations and Terraform builds a dependency graph for ordering.

[Official source](https://developer.hashicorp.com/terraform/language)

</details>

### T004-003 · Single choice

An engineer changes an instance size in code and wants to know the proposed consequences before changing production. Which IaC capability is being used?

A. Execution planning
B. State locking
C. Provider aliasing
D. Module publishing

<details><summary>Answer and rationale</summary>

**Answer:** Execution planning

A Terraform plan previews the actions needed to reconcile configuration, state, and remote objects.

[Official source](https://developer.hashicorp.com/terraform/intro/core-workflow)

</details>

### T004-004 · Multiple answer

Which two practices become easier when infrastructure is represented as code?

A. Peer review through version control
B. Reproducing an environment from a known revision
C. Avoiding all provider APIs
D. Keeping secrets permanently out of state

<details><summary>Answer and rationale</summary>

**Answer:** Peer review through version control; Reproducing an environment from a known revision

Code can be reviewed and versioned. IaC still calls provider APIs, and ordinary sensitive values can still be stored in state.

[Official source](https://developer.hashicorp.com/terraform/intro)

</details>

### T004-005 · Single choice

A company uses AWS and GitHub. Why can one Terraform workflow manage both?

A. Providers expose each platform's API resources to Terraform
B. Terraform converts both platforms into the same API
C. State replaces authentication
D. Backends install cloud SDKs

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

A. Write, plan, apply
B. Apply, import, format
C. Init, destroy, write
D. Validate, publish, unlock

<details><summary>Answer and rationale</summary>

**Answer:** Write, plan, apply

The core workflow is write configuration, review a plan, then apply it. Initialization is a setup command used when needed.

[Official source](https://developer.hashicorp.com/terraform/intro/core-workflow)

</details>

## 02 Fundamentals and Providers

### T004-008 · Single choice

A configuration uses hashicorp/aws. Where should its source address and acceptable versions be declared?

A. terraform.required_providers
B. provider.aws
C. backend
D. locals

<details><summary>Answer and rationale</summary>

**Answer:** terraform.required_providers

The required_providers block declares each provider's local name, source address, and version constraint.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/providers/requirements)

</details>

### T004-009 · Single choice

Where are an AWS region and an alias for a second region normally configured?

A. provider blocks
B. required_providers
C. output blocks
D. the lock file

<details><summary>Answer and rationale</summary>

**Answer:** provider blocks

Provider blocks configure provider-specific settings. required_providers declares source and version requirements.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/provider)

</details>

### T004-010 · Single choice

A repository was freshly cloned and has no .terraform directory. Which command installs required provider plugins?

A. terraform init
B. terraform validate
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

A. provider = aws.west
B. source = aws.west
C. alias = west
D. providers = aws.west

<details><summary>Answer and rationale</summary>

**Answer:** provider = aws.west

Resources select a non-default provider configuration with the provider meta-argument and an unquoted provider reference.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/provider)

</details>

### T004-013 · Multiple answer

What does .terraform.lock.hcl record?

A. Selected provider versions
B. Provider checksums
C. Remote module version selections
D. Current resource attributes

<details><summary>Answer and rationale</summary>

**Answer:** Selected provider versions; Provider checksums

The dependency lock file tracks provider selections and checksums. It does not track remote module version selections or resource state.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/files/dependency-lock)

</details>

### T004-014 · True/False

A team should usually commit .terraform.lock.hcl to version control.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** True

Committing the lock file lets future runs use reviewed provider selections and verify package checksums.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/files/dependency-lock)

</details>

### T004-015 · Single choice

The configuration permits AWS provider versions >= 5.0 and < 6.0, but the lock file selects 5.42. What does a normal terraform init prefer?

A. 5.42 if it still satisfies the constraint
B. The newest 5.x version every time
C. 6.0
D. No provider because constraints and locks conflict

<details><summary>Answer and rationale</summary>

**Answer:** 5.42 if it still satisfies the constraint

Terraform honors the existing locked selection when it remains compatible. Use init -upgrade to consider newer acceptable versions.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/files/dependency-lock)

</details>

### T004-016 · Single choice

Which command asks Terraform to disregard existing provider selections and choose newer versions allowed by the constraints?

A. terraform init -upgrade
B. terraform apply -refresh-only
C. terraform providers mirror
D. terraform state replace-provider

<details><summary>Answer and rationale</summary>

**Answer:** terraform init -upgrade

The -upgrade option ignores previous provider selections in the lock file while still obeying configured version constraints.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-017 · Single choice

Why does Terraform maintain state for a managed resource?

A. To map a configuration address to a remote object and retain needed metadata
B. To replace provider authentication
C. To store only comments from configuration
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
B. provider
C. required_providers
D. depends_on

<details><summary>Answer and rationale</summary>

**Answer:** providers

A module call can pass provider configurations with its providers map, for example aws = aws.west.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-020 · Single choice

Which command displays the provider requirements detected across the current configuration and its modules?

A. terraform providers
B. terraform show
C. terraform output
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
B. terraform fmt
C. terraform state pull
D. terraform login

<details><summary>Answer and rationale</summary>

**Answer:** terraform init

Initialization prepares the working directory, backend, child modules, and provider plugins.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-023 · True/False

It is safe to run terraform init more than once in the same working directory.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** True

Initialization is designed to be idempotent and can be repeated when dependencies or backend settings change.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-024 · Single choice

A backend configuration changed and existing state must be copied to the new backend. Which initialization option is intended for that?

A. -migrate-state
B. -backend=false
C. -get=false
D. -upgrade

<details><summary>Answer and rationale</summary>

**Answer:** -migrate-state

terraform init -migrate-state attempts to copy existing state to the newly configured backend. -reconfigure accepts new settings without migration.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-025 · Single choice

A reusable child module needs a syntax and internal-consistency check without accessing a configured backend. Which sequence is appropriate?

A. terraform init -backend=false, then terraform validate
B. terraform apply -refresh-only
C. terraform state list, then terraform fmt
D. terraform import, then terraform test

<details><summary>Answer and rationale</summary>

**Answer:** terraform init -backend=false, then terraform validate

Validation needs installed modules/providers but not a backend. A backend-free initialization creates the environment for validate.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/validate)

</details>

### T004-026 · Multiple answer

What does terraform validate check?

A. Configuration syntax
B. Internal argument and reference consistency
C. Whether cloud credentials can create every resource
D. Whether the proposed changes are acceptable

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

A. Speculative and not guaranteed to be the exact plan later applied
B. Saved and immutable
C. Refresh-only
D. Destroy mode

<details><summary>Answer and rationale</summary>

**Answer:** Speculative and not guaranteed to be the exact plan later applied

Without -out, plan is for review. A later apply creates a fresh plan unless given a saved plan file.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-029 · Single choice

A CI job must apply exactly the reviewed plan. Which workflow fits?

A. terraform plan -out=tfplan, then terraform apply tfplan
B. terraform plan, then terraform apply -refresh-only
C. terraform validate, then terraform apply -target=all
D. terraform show, then terraform apply -upgrade

<details><summary>Answer and rationale</summary>

**Answer:** terraform plan -out=tfplan, then terraform apply tfplan

A saved plan can be passed to apply so Terraform executes those recorded actions, subject to the plan remaining usable.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-030 · Single choice

terraform apply is run without a saved-plan argument. What happens first?

A. Terraform creates a new plan and asks for approval
B. Terraform applies the last speculative plan
C. Terraform skips refresh
D. Terraform only updates state

<details><summary>Answer and rationale</summary>

**Answer:** Terraform creates a new plan and asks for approval

Automatic plan mode creates a plan, presents it, and requests approval unless an applicable noninteractive option is used.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/apply)

</details>

### T004-031 · Single choice

Which command removes all managed objects described by the current configuration?

A. terraform destroy
B. terraform state rm '*'
C. terraform fmt -recursive
D. terraform init -reconfigure

<details><summary>Answer and rationale</summary>

**Answer:** terraform destroy

terraform destroy is a convenience alias for terraform apply -destroy. State removal alone does not destroy remote objects.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/destroy)

</details>

### T004-032 · Single choice

CI should fail if any Terraform file is not canonically formatted, without rewriting files. Which command is suitable?

A. terraform fmt -check -recursive
B. terraform validate -json
C. terraform plan -detailed-exitcode
D. terraform show -json

<details><summary>Answer and rationale</summary>

**Answer:** terraform fmt -check -recursive

fmt -check checks formatting, and -recursive includes subdirectories.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/fmt)

</details>

### T004-033 · Single choice

A team wants state to accept out-of-band changes without modifying remote resources. Which planning mode proposes only state reconciliation?

A. terraform plan -refresh-only
B. terraform plan -destroy
C. terraform plan -target
D. terraform state push

<details><summary>Answer and rationale</summary>

**Answer:** terraform plan -refresh-only

Refresh-only mode proposes updates to state and root outputs to match remote objects without planning normal infrastructure changes.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-034 · Single choice

One unhealthy instance should be replaced even though its arguments have not changed. Which planning option expresses that intent?

A. -replace=ADDRESS
B. -target=ADDRESS
C. -refresh=false
D. -lock=false

<details><summary>Answer and rationale</summary>

**Answer:** -replace=ADDRESS

The -replace option requests replacement of a specific resource instance in the plan.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-035 · True/False

Routine use of -target is recommended as the normal way to apply each resource separately.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Resource targeting is intended for exceptional recovery or troubleshooting. Normal plans should consider the whole configuration and dependency graph.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-036 · Single choice

A CI job uses terraform plan -detailed-exitcode. Which exit code means the plan succeeded and contains changes?

A. 2
B. 0
C. 1
D. 3

<details><summary>Answer and rationale</summary>

**Answer:** 2

With detailed exit codes, 0 means success with no changes, 1 means error, and 2 means success with changes.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-037 · Single choice

What is the most direct effect of -auto-approve in automatic apply mode?

A. It skips the interactive approval prompt
B. It disables state locking
C. It validates cloud permissions
D. It saves the plan to disk

<details><summary>Answer and rationale</summary>

**Answer:** It skips the interactive approval prompt

-auto-approve bypasses interactive confirmation. It does not change locking, authentication, or create a plan file.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/apply)

</details>

## 04 Configuration

### T004-038 · Single choice

Configuration declares resource "aws_instance" "web". What is its address when neither count nor for_each is used?

A. aws_instance.web
B. resource.aws_instance.web
C. aws.web.instance
D. module.aws_instance.web

<details><summary>Answer and rationale</summary>

**Answer:** aws_instance.web

A managed resource address combines resource type and local name.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/state/resource-addressing)

</details>

### T004-039 · Single choice

A team needs the ID of an existing VPC without asking Terraform to manage its lifecycle. Which block type fits?

A. data
B. resource
C. moved
D. terraform

<details><summary>Answer and rationale</summary>

**Answer:** data

A data source reads information from a provider without declaring that Terraform manages the remote object's lifecycle.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/data-sources)

</details>

### T004-040 · Single choice

A subnet argument uses aws_vpc.main.id. What dependency behavior does Terraform infer?

A. The VPC must be handled before the subnet
B. No dependency because references are only strings
C. The subnet must exist first
D. A manual depends_on is always required

<details><summary>Answer and rationale</summary>

**Answer:** The VPC must be handled before the subnet

A resource reference creates an implicit dependency that Terraform uses to order operations.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/references)

</details>

### T004-041 · Single choice

Two resources have a behavioral dependency but exchange no data. Which meta-argument can declare it explicitly?

A. depends_on
B. provider
C. count
D. lifecycle.ignore_changes

<details><summary>Answer and rationale</summary>

**Answer:** depends_on

depends_on records a dependency Terraform cannot infer from expression references. Use it only when a real hidden dependency exists.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/depends_on)

</details>

### T004-042 · Single choice

Instances created with count need the second instance's address. Which syntax is correct?

A. aws_instance.web[1]
B. aws_instance.web[2]
C. aws_instance.web.second
D. aws_instance.web["1"]

<details><summary>Answer and rationale</summary>

**Answer:** aws_instance.web[1]

count instances use zero-based numeric indices.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/count)

</details>

### T004-043 · Single choice

A resource uses for_each = {blue = ..., green = ...}. How is the blue instance addressed?

A. resource_type.name["blue"]
B. resource_type.name[0]
C. resource_type.blue
D. resource_type.name.blue.value

<details><summary>Answer and rationale</summary>

**Answer:** resource_type.name["blue"]

for_each instances use string keys in their addresses.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/for_each)

</details>

### T004-044 · Single choice

Stable server names may be added and removed independently. Which repetition mechanism usually avoids index shifting?

A. for_each with stable keys
B. count based on list length
C. a dynamic block
D. a provider alias

<details><summary>Answer and rationale</summary>

**Answer:** for_each with stable keys

Stable map or set keys give each instance an identity that does not depend on list position.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/for_each)

</details>

### T004-045 · Single choice

Which expression chooses "large" only when var.environment equals "prod"?

A. var.environment == "prod" ? "large" : "small"
B. if var.environment then "large"
C. var.environment && "large"
D. choose(var.environment, "large")

<details><summary>Answer and rationale</summary>

**Answer:** var.environment == "prod" ? "large" : "small"

Terraform conditional expressions use condition ? true_value : false_value.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/conditionals)

</details>

### T004-046 · Single choice

Repeated nested blocks must be generated from a collection inside a resource. Which construct is intended for that?

A. dynamic block
B. locals block
C. output block
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
C. output
D. required_providers

<details><summary>Answer and rationale</summary>

**Answer:** locals

Local values name expressions for reuse within a module. Input variables are part of the module's caller interface.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/locals)

</details>

### T004-048 · Single choice

No value is supplied for an input variable that has a default. What value does Terraform use?

A. The declared default
B. null in every case
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
B. TF_VAR_region
C. The variable default
D. The provider region

<details><summary>Answer and rationale</summary>

**Answer:** terraform.tfvars

Environment variables have lower precedence than terraform.tfvars and auto-loaded variable files.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/variables)

</details>

### T004-050 · Single choice

The same variable appears in terraform.tfvars and prod.auto.tfvars. Which takes precedence?

A. prod.auto.tfvars
B. terraform.tfvars
C. Whichever file is larger
D. Terraform reports a duplicate-definition error

<details><summary>Answer and rationale</summary>

**Answer:** prod.auto.tfvars

Automatically loaded *.auto.tfvars files are processed after terraform.tfvars; later sources have higher precedence.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/variables)

</details>

### T004-051 · Single choice

A CLI run uses -var-file=base.tfvars and then -var-file=prod.tfvars, both setting instance_type. Which wins?

A. prod.tfvars
B. base.tfvars
C. terraform.tfvars regardless
D. The variable default

<details><summary>Answer and rationale</summary>

**Answer:** prod.tfvars

CLI variable options are processed in order, and the later assignment takes precedence.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/variables)

</details>

### T004-052 · Single choice

In local CLI execution, which listed source normally has the highest precedence?

A. The last -var or -var-file argument
B. terraform.tfvars
C. TF_VAR_name
D. The variable default

<details><summary>Answer and rationale</summary>

**Answer:** The last -var or -var-file argument

CLI options have higher precedence than automatically loaded files, environment variables, and defaults. HCP priority variable sets are a separate HCP case.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/values/variables)

</details>

### T004-053 · Single choice

A variable has type set(string) and receives duplicate values. What collection property should the author expect?

A. Duplicates are removed and ordering is not significant
B. Duplicates and original ordering are preserved
C. Values become map keys with null values
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
C. State encryption
D. A guaranteed non-null value

<details><summary>Answer and rationale</summary>

**Answer:** A documented shape and validation by Terraform's type system

Specific type constraints define the accepted structure and permit safe attribute access. Nullability is controlled separately.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/type-constraints)

</details>

### T004-055 · Single choice

A root output contains a password and is marked sensitive = true. What does Terraform do?

A. Redacts it in normal CLI/UI output but may store it in state
B. Omits it from state
C. Hashes it before passing it to modules
D. Prevents providers from receiving it

<details><summary>Answer and rationale</summary>

**Answer:** Redacts it in normal CLI/UI output but may store it in state

Sensitive is a display-protection mechanism, not state omission or encryption.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data)

</details>

### T004-056 · Single choice

Operators want Terraform runs to use scoped AWS credentials that expire instead of distributing long-lived keys to every engineer. Which Vault pattern addresses this?

A. Use a Vault secrets engine to generate short-lived dynamic credentials
B. Commit static keys in a sensitive variable
C. Store keys in the provider dependency lock file
D. Use terraform state rm after every run

<details><summary>Answer and rationale</summary>

**Answer:** Use a Vault secrets engine to generate short-lived dynamic credentials

Vault can generate scoped, leased credentials for a run, reducing the number and lifetime of static secrets held by Terraform operators.

[Official source](https://developer.hashicorp.com/terraform/tutorials/secrets/secrets-vault)

</details>

### T004-057 · Single choice

A resource name must be unique, but replacement should be created before the old object is destroyed. Which lifecycle rule expresses that ordering?

A. create_before_destroy
B. prevent_destroy
C. ignore_changes
D. replace_triggered_by

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

A. ignore_changes for that attribute
B. prevent_destroy
C. create_before_destroy
D. replace_triggered_by

<details><summary>Answer and rationale</summary>

**Answer:** ignore_changes for that attribute

ignore_changes tells Terraform to ignore selected attribute differences during update planning after creation.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/lifecycle)

</details>

### T004-060 · Single choice

A resource should be replaced whenever another managed resource is replaced, even though no argument value changes. Which lifecycle feature is intended?

A. replace_triggered_by
B. depends_on
C. ignore_changes
D. precondition

<details><summary>Answer and rationale</summary>

**Answer:** replace_triggered_by

replace_triggered_by adds replacement triggers based on managed resource or attribute changes. depends_on affects ordering, not replacement by itself.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/lifecycle)

</details>

### T004-061 · True/False

Lifecycle rule arguments can freely use values that are unknown until apply.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Terraform processes lifecycle settings early, so only literal values can be used for these rules.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/meta-arguments/lifecycle)

</details>

### T004-062 · Single choice

An input variable must reject any CIDR that is not a /32 before planning proceeds. Which construct belongs in the variable block?

A. validation
B. postcondition
C. check
D. depends_on

<details><summary>Answer and rationale</summary>

**Answer:** validation

Custom variable validation checks an input value and returns an error when its condition is false.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/validate)

</details>

### T004-063 · Single choice

A resource must not be created unless an AMI architecture matches the requested instance architecture. Which condition is best placed before the resource operation?

A. precondition
B. postcondition
C. check
D. output sensitive

<details><summary>Answer and rationale</summary>

**Answer:** precondition

A precondition is evaluated before the resource operation and can block planning or applying when its requirement is false.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/validate)

</details>

### T004-064 · Single choice

After creating a service, its returned endpoint must use HTTPS or downstream resources must not proceed. Which construct fits?

A. postcondition
B. variable validation
C. ignore_changes
D. provider alias

<details><summary>Answer and rationale</summary>

**Answer:** postcondition

A postcondition validates a resource or data-source result after planning/applying/read and can prevent dependent operations when it fails.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/validate)

</details>

### T004-065 · Single choice

A production health assertion should run at the end of plan/apply but report a warning rather than block infrastructure changes. Which construct fits?

A. check block
B. precondition
C. postcondition
D. variable validation

<details><summary>Answer and rationale</summary>

**Answer:** check block

Check blocks run as the final validation step and report warnings without blocking the operation.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/validate)

</details>

### T004-066 · Single choice

A short-lived token must be available during a run but omitted from state and plan. Which variable setting introduced for this purpose is appropriate?

A. ephemeral = true
B. sensitive = true only
C. nullable = false
D. description = "secret"

<details><summary>Answer and rationale</summary>

**Answer:** ephemeral = true

Ephemeral values are available during an operation but omitted from state and plan files. They are commonly also marked sensitive to redact display.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data/ephemeral)

</details>

### T004-067 · Single choice

A provider resource exposes password_wo. What distinguishes a write-only argument?

A. Terraform passes it for the current operation and does not persist it in state or plan
B. It can only be set through TF_VAR
C. It is readable from terraform output
D. Terraform encrypts and persists it

<details><summary>Answer and rationale</summary>

**Answer:** Terraform passes it for the current operation and does not persist it in state or plan

Write-only arguments are provider-defined inputs used for the current operation and then discarded by Terraform.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data/ephemeral)

</details>

### T004-068 · True/False

Every provider argument automatically has a write-only variant in Terraform 1.12.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Providers must explicitly implement write-only arguments. Their availability and names are provider-specific.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/manage-sensitive-data/ephemeral)

</details>

## 05 Modules

### T004-069 · Single choice

A child module lives in ./modules/network. What source syntax should the root module use?

A. source = "./modules/network"
B. source = "modules::network"
C. version = "./modules/network"
D. provider = "./modules/network"

<details><summary>Answer and rationale</summary>

**Answer:** source = "./modules/network"

Local module sources use relative paths beginning with ./ or ../.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-070 · Single choice

Which public registry source address identifies the AWS VPC module from the terraform-aws-modules namespace?

A. terraform-aws-modules/vpc/aws
B. registry.terraform.io/aws/vpc
C. hashicorp/aws/vpc
D. github.com/terraform-aws-modules/vpc/aws

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

A. 3.2.9
B. 3.3.0
C. 4.0.0
D. 3.1.9

<details><summary>Answer and rationale</summary>

**Answer:** 3.2.9

~> 3.2.1 allows patch-level updates in the 3.2 series but not 3.3.0.

[Official source](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)

</details>

### T004-073 · Single choice

A root module needs a child module's subnet_ids output. Which reference is correct?

A. module.network.subnet_ids
B. network.output.subnet_ids
C. var.network.subnet_ids
D. data.module.network.subnet_ids

<details><summary>Answer and rationale</summary>

**Answer:** module.network.subnet_ids

Child module outputs are referenced as module.<call-name>.<output-name>.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/expressions/references)

</details>

### T004-074 · True/False

A child module can directly refer to an arbitrary resource in its caller without that value being passed as an input.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Modules have scope boundaries. A child receives values through input variables and exposes selected values through outputs.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/modules/develop/composition)

</details>

### T004-075 · Single choice

A new remote module call was added to configuration. Which command retrieves it into the working directory?

A. terraform init
B. terraform validate
C. terraform output
D. terraform state pull

<details><summary>Answer and rationale</summary>

**Answer:** terraform init

Initialization installs or updates referenced child modules according to the module source and options.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-076 · Single choice

Where does Terraform normally cache downloaded child modules within a working directory?

A. .terraform/modules
B. .terraform.lock.hcl/modules
C. terraform.tfstate/modules
D. modules.lock

<details><summary>Answer and rationale</summary>

**Answer:** .terraform/modules

Installed modules are cached under the working directory's .terraform directory. The dependency lock file does not lock module versions.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-077 · Single choice

Ten similar application stacks should be instantiated from one module using stable names. Which module meta-argument is suitable?

A. for_each
B. dynamic
C. lifecycle
D. backend

<details><summary>Answer and rationale</summary>

**Answer:** for_each

Module calls support count or for_each, with stable keys often making for_each preferable.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-078 · Single choice

A child module should use aws.eu instead of the root's default aws configuration. What belongs on the module call?

A. providers = { aws = aws.eu }
B. provider = aws.eu
C. alias = "eu"
D. required_providers = { aws = aws.eu }

<details><summary>Answer and rationale</summary>

**Answer:** providers = { aws = aws.eu }

The module providers map overrides which root provider configurations satisfy the child's provider configuration names.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

### T004-079 · Multiple answer

Which elements form a clean module interface?

A. Input variables
B. Output values
C. Direct access to caller-local resources
D. A backend block required in every child

<details><summary>Answer and rationale</summary>

**Answer:** Input variables; Output values

Inputs and outputs define module boundaries. Child modules should not configure a backend, and they cannot directly reach caller-local objects.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/modules/develop/composition)

</details>

### T004-080 · Single choice

A team wants a module discoverable with versioned releases and documentation inside its organization. Which HCP feature fits?

A. Private registry
B. State locking
C. Run trigger
D. Explorer saved view

<details><summary>Answer and rationale</summary>

**Answer:** Private registry

The private registry provides organization-scoped modules and providers with version discovery and documentation.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/registry)

</details>

### T004-081 · True/False

A module call can use both count and for_each at the same time.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

A module call may use count or for_each, but the two repetition meta-arguments are mutually exclusive.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/module)

</details>

## 06 State and Backends

### T004-082 · Single choice

What is Terraform state primarily for?

A. Binding resource instances to remote objects and retaining metadata
B. Storing provider binaries
C. Replacing configuration files
D. Encrypting every secret

<details><summary>Answer and rationale</summary>

**Answer:** Binding resource instances to remote objects and retaining metadata

State records object bindings and attributes Terraform needs to plan and apply changes.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/purpose)

</details>

### T004-083 · Single choice

Several engineers run Terraform against the same environment. What is the main benefit of a shared remote backend?

A. Shared current state and, when supported, locking
B. Automatic module versioning
C. Provider credential creation
D. Elimination of configuration drift

<details><summary>Answer and rationale</summary>

**Answer:** Shared current state and, when supported, locking

Remote state centralizes access. Many backends also provide locking, but capabilities vary by backend.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/backends)

</details>

### T004-084 · True/False

Every Terraform backend supports state locking.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Locking behavior depends on backend capabilities. Terraform automatically locks for supported operations when the backend provides it.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/locking)

</details>

### T004-085 · Single choice

A state lock remains after a crashed run. What should happen before terraform force-unlock is used?

A. Verify no active operation owns the lock and use the exact lock ID
B. Delete the entire backend
C. Run apply with -lock=false
D. Remove .terraform.lock.hcl

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

A. terraform state mv
B. terraform state rm
C. terraform import
D. terraform fmt

<details><summary>Answer and rationale</summary>

**Answer:** terraform state mv

state mv changes resource addresses in state. moved blocks are the declarative, reviewable alternative for refactors.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/mv)

</details>

### T004-088 · Single choice

Terraform should stop managing an object but leave the remote object intact. Which configuration construct can express that intent reviewably?

A. removed block with destroy = false
B. moved block
C. import block
D. lifecycle prevent_destroy only

<details><summary>Answer and rationale</summary>

**Answer:** removed block with destroy = false

A removed block can remove the object from state without destroying it when its lifecycle specifies destroy = false.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/block/removed)

</details>

### T004-089 · Single choice

What does terraform state rm do to the selected remote object?

A. It forgets the binding but does not destroy the remote object
B. It destroys it immediately
C. It imports it under a new address
D. It only hides it from terraform show

<details><summary>Answer and rationale</summary>

**Answer:** It forgets the binding but does not destroy the remote object

After state rm, Terraform no longer manages that object. A later plan may propose creating a replacement if configuration still declares it.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/rm)

</details>

### T004-090 · Single choice

An operator changes a security group rule in the cloud console. What usually exposes the difference to Terraform?

A. A refresh performed during plan or apply
B. terraform fmt
C. The provider lock file
D. A module version constraint

<details><summary>Answer and rationale</summary>

**Answer:** A refresh performed during plan or apply

Terraform reads remote objects during normal planning and compares refreshed data with configuration and prior state.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/purpose)

</details>

### T004-091 · Single choice

The out-of-band security group change is intentional and configuration will be updated later. Which mode can first record the remote reality in state without changing infrastructure?

A. apply -refresh-only
B. apply -destroy
C. state rm
D. init -migrate-state

<details><summary>Answer and rationale</summary>

**Answer:** apply -refresh-only

Refresh-only apply confirms and writes state/output updates based on remote objects without normal create/update/destroy actions.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/plan)

</details>

### T004-092 · True/False

Backend credentials hard-coded in backend configuration can be copied into .terraform metadata and plan files.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** True

HashiCorp recommends environment variables or backend-specific credential mechanisms because backend configuration values can be persisted in local metadata and plan files.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/backend)

</details>

### T004-093 · Single choice

A local backend is changed to S3 and the existing state must remain associated with the same resources. Which command begins migration?

A. terraform init -migrate-state
B. terraform state push without initialization
C. terraform apply -replace
D. terraform providers lock

<details><summary>Answer and rationale</summary>

**Answer:** terraform init -migrate-state

Backend migration is handled during reinitialization with -migrate-state.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/init)

</details>

### T004-094 · Single choice

Which file should never be confused with state even though its name contains 'lock'?

A. .terraform.lock.hcl
B. terraform.tfstate
C. terraform.tfstate.backup
D. .terraform/environment

<details><summary>Answer and rationale</summary>

**Answer:** .terraform.lock.hcl

The dependency lock file selects providers. A state lock is a backend coordination mechanism, not this file.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/files/dependency-lock)

</details>

### T004-095 · Single choice

Why is terraform state push considered dangerous?

A. It can overwrite remote state with a supplied snapshot
B. It installs untrusted providers
C. It always destroys resources
D. It disables locking permanently

<details><summary>Answer and rationale</summary>

**Answer:** It can overwrite remote state with a supplied snapshot

state push is a low-level recovery command. Incorrect state can sever or corrupt Terraform's object bindings.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/push)

</details>

### T004-096 · True/False

A local state file can contain sensitive values even if no output block prints them.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** True

State stores resource attributes needed by Terraform, including values that may be sensitive. Protect state at rest and in transit.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/sensitive-data)

</details>

### T004-097 · Single choice

A configuration uses terraform_remote_state only to read one output from another state. What access risk remains?

A. The reader must be able to access the full state snapshot
B. The reader can only ever access that single output
C. Terraform deletes non-output fields
D. The source state becomes local

<details><summary>Answer and rationale</summary>

**Answer:** The reader must be able to access the full state snapshot

Although only root outputs are exposed in expressions, credentials for terraform_remote_state generally grant access to the complete state snapshot.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/state/remote-state-data)

</details>

### T004-098 · Single choice

Within HCP Terraform, which data source is recommended for sharing outputs without granting full state access?

A. tfe_outputs
B. terraform_remote_state
C. external
D. http

<details><summary>Answer and rationale</summary>

**Answer:** tfe_outputs

HashiCorp recommends tfe_outputs because it can provide output access without the broader state-snapshot access required by terraform_remote_state.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/state)

</details>

## 07 Import Inspection Logging

### T004-099 · Single choice

An existing cloud object must become associated with aws_instance.legacy using the imperative CLI workflow. Which command is central?

A. terraform import aws_instance.legacy <remote-id>
B. terraform state mv <remote-id> aws_instance.legacy
C. terraform apply -replace=aws_instance.legacy
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
B. moved
C. removed
D. backend

<details><summary>Answer and rationale</summary>

**Answer:** import

Import blocks make import intent part of configuration and the normal plan/apply workflow.

[Official source](https://developer.hashicorp.com/terraform/language/v1.12.x/import)

</details>

### T004-102 · Single choice

An import block exists for an object with no resource block. Which plan option can produce a starting resource configuration file?

A. -generate-config-out=PATH
B. -out=PATH
C. -json=PATH
D. -chdir=PATH

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

A. terraform state show ADDRESS
B. terraform output ADDRESS
C. terraform validate ADDRESS
D. terraform console ADDRESS

<details><summary>Answer and rationale</summary>

**Answer:** terraform state show ADDRESS

state show presents the attributes stored for a single address.

[Official source](https://developer.hashicorp.com/terraform/cli/v1.12.x/commands/state/show)

</details>

### T004-105 · Single choice

A saved plan file named tfplan needs human-readable inspection. Which command is appropriate?

A. terraform show tfplan
B. terraform state show tfplan
C. terraform plan tfplan
D. terraform output tfplan

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

A. TF_LOG
B. TF_VAR_LOG
C. TERRAFORM_DEBUG
D. TF_STATE_LOG

<details><summary>Answer and rationale</summary>

**Answer:** TF_LOG

TF_LOG accepts levels such as TRACE, DEBUG, INFO, WARN, or ERROR. Disable it afterward to avoid noisy or sensitive logs.

[Official source](https://developer.hashicorp.com/terraform/internals/v1.12.x/debugging)

</details>

### T004-108 · Single choice

TF_LOG is set and logs should be written to a file as well as controlled by the logging subsystem. Which variable specifies the path?

A. TF_LOG_PATH
B. TF_DATA_DIR
C. TF_CLI_CONFIG_FILE
D. TF_WORKSPACE

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
C. One provider binary
D. A single resource instance

<details><summary>Answer and rationale</summary>

**Answer:** A collection of infrastructure with its configuration, state, variables, and runs

HCP workspaces separate infrastructure collections and keep the data and run history associated with each collection.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)

</details>

### T004-110 · True/False

HCP Terraform workspaces and Terraform CLI workspaces are the same feature with identical behavior.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

They are distinct. HCP workspaces are independently configured infrastructure units; CLI workspaces are alternate state instances within one working directory.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)

</details>

### T004-111 · Single choice

An HCP workspace uses local execution mode. Where do plan and apply execute?

A. On the operator's local machine while HCP stores state
B. In HCP disposable workers
C. Inside the private registry
D. On every team member's machine

<details><summary>Answer and rationale</summary>

**Answer:** On the operator's local machine while HCP stores state

Local execution mode uses HCP Terraform primarily as a remote state backend. Remote mode executes runs on HCP infrastructure.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/remote-operations)

</details>

### T004-112 · Multiple answer

Which features depend on remote operations rather than local execution mode?

A. Sentinel policy checks
B. Cost estimation
C. Run notifications
D. Local terraform fmt

<details><summary>Answer and rationale</summary>

**Answer:** Sentinel policy checks; Cost estimation; Run notifications

HCP run features such as policy checks, cost estimation, and notifications are associated with remote execution. fmt remains a local CLI operation.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/remote-operations)

</details>

### T004-113 · Single choice

What is the main purpose of an HCP Terraform project?

A. Group workspaces and stacks and scope permissions/settings
B. Replace every workspace with one state file
C. Store provider binaries locally
D. Create CLI aliases

<details><summary>Answer and rationale</summary>

**Answer:** Group workspaces and stacks and scope permissions/settings

Projects organize workspaces and Stacks and provide an administrative and permission boundary.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/projects)

</details>

### T004-114 · True/False

An HCP Terraform workspace can belong to several projects simultaneously.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

Every workspace and Stack belongs to exactly one project.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/projects)

</details>

### T004-115 · Single choice

An organization has not created any projects. Where are new workspaces placed?

A. Default Project
B. No project
C. The private registry
D. A CLI workspace

<details><summary>Answer and rationale</summary>

**Answer:** Default Project

Every organization has a Default Project, which cannot be deleted.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/projects)

</details>

### T004-116 · Single choice

The same cloud region and tag values must be shared by 30 workspaces. Which HCP feature is designed for this?

A. Variable set
B. Run trigger
C. Explorer view
D. Change request

<details><summary>Answer and rationale</summary>

**Answer:** Variable set

Variable sets allow reusable Terraform and environment variables to be applied across selected projects or workspaces, or globally.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/variables/managing-variables)

</details>

### T004-117 · Single choice

A priority variable set and a workspace variable both set region. Which value wins?

A. The priority variable-set value
B. The workspace value
C. Whichever was created first
D. Terraform fails with a conflict

<details><summary>Answer and rationale</summary>

**Answer:** The priority variable-set value

Priority variable sets override values at more specific scopes, including workspace variables and run-specific inputs.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/variables/managing-variables)

</details>

### T004-118 · Single choice

A VCS-connected workspace detects a commit to its configured branch. What workflow can HCP Terraform initiate?

A. Queue a speculative or normal run based on workspace settings
B. Rewrite the Git history
C. Publish a provider automatically
D. Force-unlock every workspace

<details><summary>Answer and rationale</summary>

**Answer:** Queue a speculative or normal run based on workspace settings

The VCS-driven workflow connects repository changes to HCP runs, subject to workspace trigger and auto-apply settings.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/vcs)

</details>

### T004-119 · Single choice

Terraform 1.12 configuration should integrate directly with HCP Terraform from the CLI. Which top-level block is intended?

A. cloud
B. remote_state
C. hcp
D. login

<details><summary>Answer and rationale</summary>

**Answer:** cloud

The cloud block configures CLI integration with HCP Terraform, including organization and workspace selection.

[Official source](https://developer.hashicorp.com/terraform/cli/cloud/settings)

</details>

### T004-120 · Single choice

A local state is being migrated to HCP Terraform. Which preliminary action reduces the risk of concurrent state changes?

A. Stop other Terraform operations before initializing the migration
B. Delete local state first
C. Disable locking
D. Remove all provider constraints

<details><summary>Answer and rationale</summary>

**Answer:** Stop other Terraform operations before initializing the migration

Migration guidance recommends preventing concurrent runs, authenticating, configuring the cloud integration, and then initializing/migrating carefully.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/migrate)

</details>

### T004-121 · Single choice

Workspace networking applies successfully. An application workspace should then queue a run. Which feature models this relationship?

A. Run trigger
B. Variable set
C. Private registry
D. Explorer

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

A. Dynamic provider credentials using OIDC
B. A sensitive workspace variable containing a permanent key
C. The dependency lock file
D. terraform_remote_state

<details><summary>Answer and rationale</summary>

**Answer:** Dynamic provider credentials using OIDC

HCP authenticates a run to the cloud through OIDC and the cloud returns temporary, narrowly scoped credentials.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials)

</details>

### T004-124 · Single choice

Security rules must evaluate the proposed plan before apply across selected projects. Which HCP organizational construct attaches those rules?

A. Policy set
B. Run trigger
C. Variable set
D. Workspace tag only

<details><summary>Answer and rationale</summary>

**Answer:** Policy set

Policy sets group policy rules and can be attached globally or to selected projects/workspaces for plan enforcement.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/policy-enforcement)

</details>

### T004-125 · Single choice

What is the difference between drift detection and continuous validation in HCP health assessments?

A. Drift detection compares real infrastructure with state; continuous validation evaluates checks against current data
B. Drift detection formats code; continuous validation installs providers
C. They are identical labels
D. Continuous validation changes resources automatically

<details><summary>Answer and rationale</summary>

**Answer:** Drift detection compares real infrastructure with state; continuous validation evaluates checks against current data

Health assessments distinguish state drift from ongoing check-block assertions. Assessments report health and do not inherently mutate infrastructure.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/health)

</details>

### T004-126 · Single choice

An administrator needs an organization-wide view of workspaces with drifted state or failed checks. Which feature is designed for this?

A. Explorer
B. Private registry
C. Run trigger
D. CLI workspace select

<details><summary>Answer and rationale</summary>

**Answer:** Explorer

Explorer queries and summarizes workspace, module, provider, version, drift, and check information across the organization.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/explorer)

</details>

### T004-127 · True/False

An Explorer saved view stores a frozen copy of the current results forever.

A. True
B. False

<details><summary>Answer and rationale</summary>

**Answer:** False

A saved view stores the query. Results update as organization data changes.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/explorer)

</details>

### T004-128 · Single choice

Remote runs must reach resources accessible only inside a private network. Which HCP capability is commonly used?

A. Terraform agents
B. CLI workspaces
C. The public module registry
D. terraform fmt

<details><summary>Answer and rationale</summary>

**Answer:** Terraform agents

Agents execute HCP Terraform work in customer-controlled network environments while retaining the HCP workflow.

[Official source](https://developer.hashicorp.com/terraform/cloud-docs/agents)

</details>

