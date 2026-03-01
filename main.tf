
#VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true


  tags = local.vpc_final_tags
}

#internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = local.igw_final_tags
}

#Public_subnets

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  count = length(var.public_cidr)
  cidr_block = var.public_cidr[count.index]



  tags = local.public_subnet_final_tags
}