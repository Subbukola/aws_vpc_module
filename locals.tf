locals {
  common_tags={
    project=var.project
    environment= var.env
    terraform= "true"
  }

  vpc_final_tags= merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-vpc"
    },
    var.vpc_tags


  )

  igw_final_tags= merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-igw"
    },
    var.igw_tags
  )

    public_subnet_final_tags= merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-public"
    },
    var.public_subnet_tags
  )
    az_names= slice(data.aws_availability_zones.available.names,0,2)

}


