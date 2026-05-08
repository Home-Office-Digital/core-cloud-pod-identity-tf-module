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

module "eks_pod_identity_arn_association" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks-pod-identity.git?ref=776d089cf8b13dbff25e32e78272f8f693f5cb29"

  for_each = try(var.association_config.simple_policy_association, {})

  use_name_prefix = false
  name            = each.key
  role_arn        = var.existing_role_arn

  additional_policy_arns = tomap({
    for arn_policy in each.value.iam_policy_arn_association :
    element(split("/", arn_policy), length(split("/", arn_policy)) - 1) => arn_policy
  })

  association_defaults = try(each.value.association_defaults, {})

  associations = tomap(each.value.cluster_association)
  tags         = var.tags
}


