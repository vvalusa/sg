output "id" {
  value       = aws_security_group.security_group.id
  description = "The ID of the security group"
}

output "arn" {
  value       = aws_security_group.security_group.arn
  description = "The ARN of the security group"
}
