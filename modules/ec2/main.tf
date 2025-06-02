# Lookup the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Lookup the existing key pair by name
resource "aws_key_pair" "deployer" {
  key_name   = "hw2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Create EC2 instances
resource "aws_instance" "this" {
  for_each = {
    for i in var.instances : i.name => i
  }

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = each.value.subnet_id
  key_name      = data.aws_key_pair.default.key_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
            EOF

  tags = {
    Name = each.value.name
  }
}
