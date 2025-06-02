terraform {
  backend "s3" {
    bucket = "vlad-bucket"
    key    = "tf-handson2/terraform.tfstate"
    region = "us-east-1"
  }
}
