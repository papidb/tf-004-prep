resource "random_pet" "hcp_demo" {
  length    = 2
  separator = "-"
}

output "pet_name" {
  value = random_pet.hcp_demo.id
}
