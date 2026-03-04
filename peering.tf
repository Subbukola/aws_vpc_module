data "aws_vpc" "default_vpc" {
  default = true
}


resource "aws_vpc_peering_connection" "foo" {

  #Accepter
  peer_vpc_id   = aws_vpc.default.id

  #requester
  vpc_id        = aws_vpc.vpc.id


  #accepting auto peer request
  auto_accept   = true


}   