resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id

  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}
# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_association" {
  for_each       = { for idx, subnet_id in var.public_subnet_ids : idx => subnet_id }
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}