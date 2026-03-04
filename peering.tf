resource "aws_vpc_peering_connection" "vpc_peering" {

  #Accepter
  peer_vpc_id   = data.aws_vpc.default_vpc.id

  #requester
  vpc_id        = aws_vpc.vpc.id


  #accepting auto peer request
  auto_accept   = true

  tags = {
    Name = "VPC Peering between foo and bar"
  }


}   