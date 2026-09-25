terraform {
  required_version = ">= 1.5"

  cloud {
    organization = "danielubenjamin-tf004"
    workspaces {
      name = "tf004-day8-migration"
    }
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}
