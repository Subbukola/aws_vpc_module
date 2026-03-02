
#VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true


  tags = local.vpc_final_tags
}

#internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = local.igw_final_tags
}

#Public_subnets

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
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
  vpc_id     = aws_vpc.vpc.id
  count = length(var.public_cidr)
  cidr_block = var.public_cidr[count.index]
  availability_zone=local.az_names[count.index]
   map_public_ip_on_launch= true


  tags = merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-private-${local.az_names[count.index]}"
    },
    var.private_subnet_tags
  )
}



#Database_subnets

resource "aws_subnet" "database" {
  vpc_id     = aws_vpc.vpc.id
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

#Public route table

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id


  tags = local.public_route_final_tags
}


#Private route table

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  tags = local.private_route_final_tags
}

#adding route to public route table
resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id=aws_internet_gateway.gw.id
}

#elasticIP
resource "aws_eip" "eip" {
  
  domain   = "vpc"

  tags = merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-eip"
    },
    var.eip_tags
  )


}


# NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public.id

  
  tags = merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-NAT"
    },
    var.NAT_tags
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

#adding route to private route table
resource "aws_route" "private_route" {
  route_table_id            = aws_route_table.private_route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id=aws_nat_gateway.nat
}

