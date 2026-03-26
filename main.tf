provider "aws" {
  region = "us-east-1"
}

# ❌ Public S3 bucket
resource "aws_s3_bucket" "bad_bucket" {
  bucket = "my-public-bucket-demo-12345"
  acl    = "public-read"
}

# ❌ Security group open to the world
resource "aws_security_group" "bad_sg" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open SSH to world
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ❌ Hardcoded secret
variable "db_password" {
  default = "SuperSecret123!"
}

# ❌ Unencrypted EBS volume
resource "aws_ebs_volume" "bad_volume" {
  availability_zone = "us-east-1a"
  size              = 10
  encrypted         = false
}

# ❌ Public EC2 instance
resource "aws_instance" "bad_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  associate_public_ip_address = true
}
