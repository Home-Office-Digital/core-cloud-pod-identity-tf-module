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
- Pod Identity Association to bind to existing or created IAM Role

Recommended settings:

- Create pod identity associations for custom tenant created roles (no associations for role names pre-fixed with cc-*)
- Only pod identity associations for namespaces managed by your respective team

See the below example configuration :

```
terraform {
  source = "https://github.com/Home-Office-Digital/core-cloud-pod-identity-tf-module.git?ref={tag}"
}

  # Tags for all resources
  tags = {
    cost-centre      = "xxx"
    account-code     = "xxx"
    portfolio-id     = "xxx"
    project-id       = "xxx"
    service-id       = "xxx"
    environment-type = "xxx"
    owner-business   = "xxx"
    budget-holder    = "xxx"
    source-repo      = "xxx"
  }

```

## Requirements

