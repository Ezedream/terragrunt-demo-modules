# ---------------------------------------------------------------------------------------------------------------------
# USE THE DEFAULT VPC AND SUBNETS
# To keep this example simple, we use the default VPC and subnets, but in real-world code, you'll want to use a
# custom VPC.
# ---------------------------------------------------------------------------------------------------------------------

/*
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
*/

// ----------- VPC -----------
resource "aws_vpc" "terragrunt-demo-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

// ----------- Subnet -----------
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.terragrunt-demo-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"

}

resource "aws_subnet" "public_subnet_bis" {
  vpc_id            = aws_vpc.terragrunt-demo-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1b"

}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.terragrunt-demo-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1a"

}
resource "aws_subnet" "private_subnet_bis" {
  vpc_id            = aws_vpc.terragrunt-demo-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1b"

}


# Récupérer les sous-réseaux du VPC personnalisé
data "aws_subnet_ids" "default" {
  vpc_id = aws_vpc.terragrunt-demo-vpc.id
}