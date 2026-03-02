
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

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.public.id
  count = length(var.public_cidr)
  cidr_block = var.public_cidr[count.index]
  availability_zone=local.az_names[count.index]
   map_public_ip_on_launch= true


  tags = merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-public-${local.az_names[count.index]}"
    },
    var.public_subnet_tags
  )
}

#Private_subnets

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.private.id
  count = length(var.public_cidr)
  cidr_block = var.public_cidr[count.index]
  availability_zone=local.az_names[count.index]
   map_public_ip_on_launch= true


  tags = merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-public-${local.az_names[count.index]}"
    },
    var.public_subnet_tags
  )
}



#Database_subnets

resource "aws_subnet" "database" {
  vpc_id     = aws_vpc.database.id
  count = length(var.database_cidr)
  cidr_block = var.database_cidr[count.index]
  availability_zone=local.az_names[count.index]

  tags = merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-database-${local.az_names[count.index]}"
    },
    var.database_subnet_tags
  )
}