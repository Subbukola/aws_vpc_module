data "aws_availability_zones" "available" {
  state = "available"
 
  }

# data "aws_vpc" "selected" {
#   id = var.vpc_id
# }

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_route_tables" "default" {
  vpc_id = data.aws_vpc.default_vpc.id


}