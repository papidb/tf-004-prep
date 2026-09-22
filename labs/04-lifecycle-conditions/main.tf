resource "random_pet" "a" {
  length = 2
}

resource "random_pet" "b" {
  length = 2
  keepers = {
    "a_id" = random_pet.a.id
  }
}

resource "random_pet" "b" {
  length = 2
  depends_on = [ random_pet.a ]
}
