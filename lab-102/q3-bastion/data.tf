data "aws_availability_zones" "this" {
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "sn" {
  vpc_id               = data.aws_vpc.default.id
  availability_zone_id = data.aws_availability_zones.this.zone_ids[0]
}
