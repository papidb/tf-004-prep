resource "random_pet" "cat" {

}


resource "random_pet" "dog" {
  provider = random.alt
}


module "dog" {
  source = "./modules/petnames"
  providers = {
    random.alt = random.alt
  }
}
