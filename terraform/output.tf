# output "private_key" {
#   description = "EC2 private key."
#   value       = tls_private_key.custom_key.private_key_pem
#   sensitive   = true
# }

output "dev_ip" {
  value = aws_instance.dev_node.public_ip

}
