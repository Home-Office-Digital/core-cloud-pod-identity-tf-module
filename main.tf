locals {
  create_role = var.existing_role_arn == null
}


data "aws_iam_policy_document" "pod_identity_assume" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pod.eks.amazon.com"]
    }

    actions = [
      "sts.AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "this" {
  count              = local.create_role ? 1 : 0
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.pod_identity_assume.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "role_policy" {
  policy_arn = var.policy_arn
  role       = aws_iam_role.this.name
}

resource "aws_eks_pod_identity_association" "pod_identity_association" {
  cluster_name    = var.cluster_name
  namespace       = var.namespace
  service_account = var.service_account_name
  role_arn        = coalesce(var.existing_role_arn, aws_iam_role.this.arn)
}


