output "role_name" {
  value     = var.create_role ? aws_iam_role.this[0].name : null
  sensitive = true
}

output "role_arn" {
  value     = var.create_role ? aws_iam_role.this[0].arn : var.existing_role_arn
  sensitive = true
}
