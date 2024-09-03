
resource "aws_instance" "mmo-instance" {
  for_each = var.instance
  instance_type = each.value.instance_type
  ami = each.value.ami
  subnet_id = aws_subnet.mmo-public.id
  key_name = each.value.key_name
  user_data = each.value.user_data
  vpc_security_group_ids = [aws_security_group.mmo-nsg.id]
  tags = {
    Name = each.value.name
  }
}