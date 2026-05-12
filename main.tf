resource "aws_iam_role" "this" {
  count = var.create_role == false ? 1 : 0
  name  = var.role_name
  assume_role_policy = jsondecode({
    Version = "2012-10-17"
    Statement = [{
      Actions = [
        "sts:AssumeRole",
        "sts:TagSession"
      ]
      Effect = "Allow"
      Principle = {
        Service = "pod.eks.amazon.com"
      }
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "role_policy" {
  policy_arn = var.policy_arn
  role = coalesce(var.existing_role_name,
  try(aws_iam_role.this[0].name, null))
}

resource "aws_eks_pod_identity_association" "pod_identity_association" {
  cluster_name    = var.cluster_name
  namespace       = var.namespace
  service_account = var.service_account_name
  role_arn        = coalesce(var.existing_role_arn, try(aws_iam_role.this[0].arn, null))
}
