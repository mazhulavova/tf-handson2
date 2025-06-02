module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "my-vpc"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id

  public_subnets = [
    { az = "us-east-1a", cidr = "10.0.1.0/24" },
    { az = "us-east-1b", cidr = "10.0.2.0/24" }
  ]

  private_subnets = [
    { az = "us-east-1a", cidr = "10.0.3.0/24" },
    { az = "us-east-1b", cidr = "10.0.4.0/24" }
  ]

  tags = {
    Project = "vpc-subnet-setup"
  }
}
