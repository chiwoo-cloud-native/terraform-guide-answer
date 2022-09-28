# EIP
resource "aws_eip_association" "eip_assoc_bastion" {
  instance_id   = aws_instance.bastion.id
  allocation_id = data.aws_eip.bastion.id
  depends_on    = [
    aws_instance.bastion
  ]
}
