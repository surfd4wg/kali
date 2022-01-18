resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  tags = merge(
        local.common_tags,

        tomap(
          {"Zoo" = "R3Dfarm"
          "RESOURCE" = "vpc-R3Dlabs"
          }
        )
        )
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(
        local.common_tags,

        tomap(
          {"Zoo" = "R3Dfarm"
          "RESOURCE" = "igw-R3Dlabs"
          }
        )
        )
}
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = var.avail_zone
  tags = merge(
        local.common_tags,

        tomap(
          {"Zoo" = "R3Dfarm"
          "RESOURCE" = "subnet-R3Dlabs"
          }
        )
        )
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(
        local.common_tags,

        tomap(
          {"Zoo" = "R3Dfarm"
          "RESOURCE" = "rtb-R3Dlabs"
          }
        )
        )
}
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.default.id

}

resource "aws_eip" "r3dlocust-labs" {
  vpc        = true
  depends_on = [aws_internet_gateway.main]
  count = var.instance_count
  instance = aws_instance.webserver[count.index].id

  tags = merge(
        local.common_tags,

        tomap(
          {"Zoo" = "R3Dfarm"
          "RESOURCE" = "eip-R3Dlabs"
          }
        )
        )
}
