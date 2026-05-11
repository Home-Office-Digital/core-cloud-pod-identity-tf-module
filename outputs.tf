output "pod_identity_role_arn" {
  value     = var.create_iam_role ? module.eks_pod_identity_arn_association.iam_role_arn : var.existing_role_arn
  sensitive = true
}
