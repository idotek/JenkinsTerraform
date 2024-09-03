resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits = 4096
}


resource "aws_key_pair" "mmo-K32ATyeSIHotPt6Mw9" {
  key_name = "tfkey"
  public_key = tls_private_key.key.public_key_openssh
}
resource "local_sensitive_file" "privkey" {
  content = tls_private_key.key.private_key_pem
  filename = "tfkeypriv"
  file_permission = "600"
}