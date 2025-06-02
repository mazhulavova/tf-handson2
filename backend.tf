terraform {
  backend "s3" {
    bucket = "my-terraform-backet-hw1"
    key    = "tf-handson2/terraform.tfstate"
    region = "us-east-1"
  }
}
