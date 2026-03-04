data "aws_availability_zones" "available" {
  state = "available"
 
  }

# data "aws_vpc" "selected" {
#   id = var.vpc_id
# }

data "aws_vpc" "default_vpc" {
  default = true
}
