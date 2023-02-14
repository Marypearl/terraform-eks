#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "tha-prod-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "tha-prod-eks-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "tha-prod-vpc" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.tha-prod-vpc.id

  tags = map(
    "Name", "tha-prod-eks-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "tha-prod-vpc" {
  vpc_id = aws_vpc.tha-prod-vpc.id

  tags = {
    Name = "tha-prod-vpc"
  }
}

resource "aws_route_table" "tha-prod-vpc" {
  vpc_id = aws_vpc.tha-prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tha-prod-vpc.id
  }
}

resource "aws_route_table_association" "tha-prod-vpc" {
  count = 2

  subnet_id      = aws_subnet.tha-prod-vpc.*.id[count.index]
  route_table_id = aws_route_table.tha-prod-vpc.id
}
