resource "random_pet" "cat" {

}


resource "random_pet" "dog" {
  provider = random.alt

}
