variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}
variable "vpc_tags" {
    type = map(string)
    default = {}
  
}

variable "project" {
    type = string
  
}

variable "env" {
    type = string

  
}

variable "igw_tags" {
    type = map(string)
    default = {}
  
}

variable "public_cidr" {
    type = list(string)
    default = ["10.0.1.0/24","10.0.2.0/24"]
  
}
variable "public_subnet_tags" {
    type = map(string)
    default = { }
  
}

variable "private_cidr" {
  
  type = list(string)
  default = ["10.0.11.0/24","10.0.22.0/24"]
}

variable "private_subnet_tags" {
    type = map(string)
    default = { }
  
}

variable "database_cidr" {

  type = list(string)
  default = ["10.0.31.0/24","10.0.32.0/24"]
  
}

variable "database_subnet_tags" {
    type = map(string)
    default = { }
  
}