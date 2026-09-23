resource "random_pet" "a" {
  length = var.pet_length
  lifecycle {
    create_before_destroy = true
    postcondition {
      condition     = length(self.id) > 0
      error_message = "id must be non-empty"
    }
  }
}

resource "random_pet" "b" {
  length = 2
  keepers = {
    "a_id" = random_pet.a.id
  }
  lifecycle {
    precondition {
      condition     = random_pet.a.length >= 2
      error_message = "id of a has to be greater or equal to 2"
    }
  }
}

resource "random_pet" "c" {
  length     = 2
  depends_on = [random_pet.a]
}

variable "pet_length" {
  type = number
  validation {
    condition     = var.pet_length >= 1 && var.pet_length <= 5
    error_message = "Has to be between 1 and 5"
  }
}

check "pet_names_distinct" {
  assert {
    condition     = random_pet.a.id != random_pet.b.id
    error_message = "a.id and b.id must be distinct"
  }
}
