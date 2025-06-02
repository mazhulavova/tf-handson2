module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "tf-handson2-vpc"
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

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
  name   = "my-vpc-igw"
  
}
module "natgw" {
  source           = "./modules/natgw"
  public_subnet_id = module.subnets.public_subnet_ids[0]
  igw_id           = module.igw.igw_id 
  name             = "my-nat-gateway"
 
}
module "rtb" {
  source           = "./modules/rtb"
  vpc_id           = module.vpc.vpc_id
  igw_id           = module.igw.igw_id
  nat_gateway_id   = module.natgw.nat_gateway_id
}

module "route_table_association" {
  source = "./modules/route_table_association"

  public_subnet_ids        = module.subnets.public_subnet_ids
  private_subnet_ids       = module.subnets.private_subnet_ids
  public_route_table_id    = module.rtb.public_route_table_id
  private_route_table_id   = module.rtb.private_route_table_id
}


module "security_group" {
  source      = "./modules/security_group"
  name        = "ec2-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = module.vpc.vpc_id
  ssh_cidr_blocks = ["0.0.0.0/0"] 
}
module "ec2" {
  source = "./modules/ec2"

  key_name          = "hw2-key" 
  instance_type     = "t2.micro"
  security_group_id = module.security_group.security_group_id

  instances = [
    {
      name      = "web-server-1a"
      subnet_id = module.subnets.public_subnet_ids[0]
    },
    {
      name      = "web-server-1b"
      subnet_id = module.subnets.public_subnet_ids[1]
    }
  ]
}
module "target_group" {
  source = "./modules/target_group"

  name              = "ec2-target-group"
  vpc_id            = module.vpc.vpc_id
  port              = 80
  protocol          = "HTTP"
  health_check_path = "/"

  tags = {
    Environment = "dev"
    Project     = "my-project"
  }
}
module "ssl_tls" {
  source = "./modules/ssl_tls"

  domain_name = "rozdavalo.com"
  subject_alternative_names = ["www.rozdavalo.com"]
  route53_zone_id = "Z018554930KHD4P0FHFY8"  # Replace with your real hosted zone ID

  tags = {
    Environment = "dev"
    Name        = "acm-cert"
  }
}
module "load_balancer" {
  source = "./modules/load_balancer"

  name              = "my-alb"
  subnet_ids        = module.subnets.public_subnet_ids
  security_group_id = module.security_group.security_group_id

  target_group_arn  = module.target_group.target_group_arn
  certificate_arn   = module.ssl_tls.certificate_arn
  enable_https      = true

  tags = {
    Environment = "dev"
    Project     = "my-web"
  }
}
module "route53" {
  source = "./modules/route53"

  zone_id       = "Z018554930KHD4P0FHFY8"                  # Replace with your Route 53 Hosted Zone ID
  record_name   = "www.rozdavalo.com"              # The domain or subdomain you want to use
  alb_dns_name  = module.load_balancer.dns_name     # ALB DNS name from ALB module
  alb_zone_id   = "Z35SXDOTRQ7X7K"                  # ALB's hosted zone ID (use correct one per region)
}

