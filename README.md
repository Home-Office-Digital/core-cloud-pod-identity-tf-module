# Core Cloud Pod Identity Module

This Pod Identity Child Module is written and maintained by the Core Cloud Platform team and includes the following checks and scans:
Terraform validate, Terraform fmt, TFLint, Checkov scan, Sonarqube scan and Semantic versioning - MAJOR.MINOR.PATCH.

## Module Structure

<strong>---| .github</strong>  
&nbsp;&nbsp;&nbsp;&nbsp;<strong>---| [dependabot.yaml](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/.github/dependabot.yaml)</strong> - Checks repository daily for any dependency updates and raises a PR into main for review.  \
&nbsp;&nbsp;&nbsp;&nbsp;<strong>---| workflows</strong> \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>---| [pull-request-sast.yaml](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/.github/workflows/pull-request-sast.yaml)</strong> - Workflow containing terraform init, terraform validate, terraform fmt - referencing Core Cloud TFLint, Checkov scan and Sonarqube scan shared workflows. Runs on pull request and merge to main branch. \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>---| [pull-request-semver-label-check.yaml](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/.github/workflows/pull-request-semver-label-check.yaml)</strong> - Verifies all PRs to main raised in the module must have an appropriate semver label: major/minor/patch. \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>---| [pull-request-semver-tag-merge.yaml](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/.github/workflows/pull-request-semver-tag-merge.yaml)</strong> - Calculates the new semver value depending on the PR label and tags the repository with the correct tag. \
<strong>---| tests</strong> \
&nbsp;&nbsp;<strong>---| [pod-identity-basic.tftest.hcl](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/tests/pod-identity-basic.tftest.hcl)</strong> \
<strong>---| [CHANGELOG.md](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/CHANGELOG.md)</strong> - Contains all significant changes in relation to a semver tag made to this module. \
<strong>---| [CODEOWNERS](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/CODEOWNERS)</strong> \
<strong>---| [CONTRIBUTING.md](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/LICENSE.md)</strong>  \
<strong>---| [LICENSE.md](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/LICENSE.md)</strong>  \
<strong>---| [README.md](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/README.md)</strong>  \
<strong>---| [main.tf](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/main.tf)</strong> - Contains the main set of configuration for this module.  \
<strong>---| [outputs.tf](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/outputs.tf)</strong> - Contain the output definitions for this module.  \
<strong>---| [variables.tf](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/variables.tf)</strong> - Contains the declarations for module variables, all variables have a defined type and short description outlining their purpose.  \
<strong>---| [versions.tf](https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module/blob/main/versions.tf)</strong> - Contains the providers needed by the module.  

## Terraform Tests

All module tests are located in the test/ folder and uses Terraform test. These are written and maintained by the Core Cloud QA team.  \
The test files found in this folder validate the Pod Identity module configuration.  \
Please refer to the [Official Hashicorp Terraform Test documentation](https://developer.hashicorp.com/terraform/language/tests).

## Usage 

This module will create the following:
- Optional IAM Role
- EKS Pod Identity Trust Policy for IAM Roles created using this module, not existing roles
- Pod Identity Association to bind to existing or created IAM Role

Recommended settings:

- Create pod identity associations for custom tenant created roles (no associations for role names pre-fixed with cc-*)
- Only pod identity associations for namespaces managed by your respective team

See the below example configuration :

```
terraform {
  source = "https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module.git?ref={tag}"
}

inputs = {

  create_role          = false
  existing_role_arn    = "arn:aws:iam::xxx:role/test-role"
  policy_arn           = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  cluster_name         = "test"
  namespace            = "test"
  service_account_name = "test-sa"


  # Tags for all resources
  tags = {
    Environment      = "test"
    Project          = "test-project"
    cost-centre      = "xxx"
    account-code     = "xxx"
    portfolio-id     = "xxx"
    project-id       = "xxx"
    service-id       = "xxx"
    environment-type = "test"
    owner-business   = "xxx"
    budget-holder    = "xxx"
    source-repo      = "xxx"
  }
}

```

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.88.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.88.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_eks_pod_identity_association.pod_identity_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_pod_identity_association) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | n/a | `bool` | `false` | no |
| <a name="input_existing_role_arn"></a> [existing\_role\_arn](#input\_existing\_role\_arn) | n/a | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | n/a | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | n/a | `string` | `null` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
