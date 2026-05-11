module "eks_pod_identity_arn_association" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks-pod-identity.git?ref=776d089cf8b13dbff25e32e78272f8f693f5cb29"

  for_each = try(var.association_config.simple_policy_association, {})

  use_name_prefix            = false
  name                       = each.key
  create_iam_role            = var.create_iam_role
  iam_role_arn               = var.create_iam_role ? null : var.existing_role_arn
  attach_external_dns_policy = var.create_iam_role

  additional_policy_arns = tomap({
    for arn_policy in each.value.iam_policy_arn_association :
    element(split("/", arn_policy), length(split("/", arn_policy)) - 1) => arn_policy
  })

  association_defaults = try(each.value.association_defaults, {})

  associations = tomap(each.value.cluster_association)
  tags         = var.tags
}


