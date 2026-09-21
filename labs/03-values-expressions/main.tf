variable "environment" {
  type = object({
    name           = string
    instance_count = number
  })
}

variable "tier" {
  type    = string
  default = "standard"
}

variable "pet_names" {
  type    = list(string)
  default = ["web", "api", "db"]
}

variable "ssh_cidr" {
  type = string

  validation {
    condition     = (endswith(var.ssh_cidr, "/32") && can(cidrhost(var.ssh_cidr, 0)))
    error_message = "The host_ip must be a valid IPv4 CIDR block ending in '/32' (e.g., 10.0.1.5/32)."
  }

  validation {
    condition     = var.ssh_cidr != "0.0.0.0/0"
    error_message = "Can't be open to the internet"
  }

}

locals {
  name_prefix = "${var.environment.name}-${var.tier}"
  is_prod     = var.environment.name == "prod"
  upper_names = [for resource in ["web", "api", "db"] : upper(resource)]
}

resource "random_pet" "server_pets" {
  for_each = toset(["web", "api", "db"])
  prefix   = each.key
  length   = 2
}

resource "random_pet" "count_pets" {
  count  = length(var.pet_names)
  prefix = var.pet_names[count.index]
  length = 2
}

output "name_prefix" {
  value = local.name_prefix
}

output "pet_ids_hash_map" {
  value = { for key, instance in random_pet.server_pets : key => instance.id }
}
output "pet_ids_array" {
  value = [for key, instance in random_pet.server_pets : instance.id]
}

output "resolved_tier" {
  value = var.tier
}


# variable input: {name: "daniel", instance_count: 1}
