resource "random_pet" "a" {
  length = 4
  lifecycle {
    create_before_destroy = true
  }
}

resource "random_pet" "b" {
  length = 2
  keepers = {
    "a_id" = random_pet.a.id
  }
}

resource "random_pet" "c" {
  length     = 2
  depends_on = [random_pet.a]
  lifecycle {
    prevent_destroy = true
  }
}
