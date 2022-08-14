output "ip" {
  description = "IP address of the instance"
  #value       = aws_instance.test.private_ip
  value = [for instance in aws_instance.test : instance.private_ip]
}