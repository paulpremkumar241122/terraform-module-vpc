resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  tags = merge ({
    Name = "${var.env}-vpc"
  },
    var.tags)
}

module "aws_subnets" {
  source = "./subnets"
  for_each = var.subnets

  vpc_id = aws_vpc.main.id

  cidr_block = each.value["cidr_block"]
  subnet_name = each.key

  env = var.env
  tags = var.tags
}