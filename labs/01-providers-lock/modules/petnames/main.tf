resource "random_pet" "module_pet" {
  provider = random.alt
}

output "pet_id" {
  value = random_pet.module_pet.id
}
