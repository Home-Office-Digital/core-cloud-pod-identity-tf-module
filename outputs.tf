output "role_name" {
  value     = local.create_role ? cc_iam_role.this[0].name : null
  sensitive = true
}

output "role_arn" {
  value     = local.create_role ? cc_iam_role.this[0].arn : var.existing_role_arn
  sensitive = true
}
