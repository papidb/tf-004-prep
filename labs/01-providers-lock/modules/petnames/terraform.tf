terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      # Declares a provider-config SLOT this module expects to be passed in
      # (internally referenced as random.alt). Aliased configs are never
      # inherited implicitly, so the slot must be declared, not configured here.
      configuration_aliases = [random.alt]
    }
  }
}
