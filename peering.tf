resource "aws_vpc_peering_connection" "vpc_peering" {

  #Accepter
  peer_vpc_id   = data.aws_vpc.default_vpc.id

  #requester
  vpc_id        = aws_vpc.vpc.id


  #accepting auto peer request
  auto_accept   = true

  tags = local.vpc_peering_final_tags


}   


#default vpc to myVPC
resource "aws_route" "route_to_my_vpc" {
  route_table_id            = data.aws_route_table.default_rt.id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

# myVPC to default VPC
resource "aws_route" "route_to_default_vpc" {
  route_table_id            = data.aws_route_table.default_rt.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}
