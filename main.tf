data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "this" {
  count              = var.create_role == true ? 1 : 0
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
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
