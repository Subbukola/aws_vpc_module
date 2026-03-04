output "availability_zone"{
    value = data.aws_availability_zones.available.names
}

output "default_vpc_id" {
    value = data.aws_vpc.default_vpc.id
  
}

output "my_vpc_id" {
    value = aws_vpc.vpc.id
  
}