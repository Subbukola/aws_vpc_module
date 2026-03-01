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

  igw_files_tags= merge(

    local.common_tags,
    {
        Name="${var.project}-${var.env}-igw"
    },
    var.igw_tags
  )
}


