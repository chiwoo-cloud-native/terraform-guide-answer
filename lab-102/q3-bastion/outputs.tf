output "availability_zone_ids" {
  value = data.aws_availability_zones.this.zone_ids
}

output "subnet_id" {
  value = data.aws_subnet.sn.id
}
