## Pod Identity TF Tests
// Mock providers to avoid real AWS calls during tests.
mock_provider "aws" {}

run "iam_role_created_successfully" {
  command = plan

variables {
  create_role = true
  role_name = "testing-role"
}

  assert {
    condition     = aws_iam_role.this.name == "testing-role"
    error_message = "IAM Role not created with expected name"
  }

  assert {
    condition     = aws_iam_role.this.arn != ""
    error_message = "IAM Role ARN should not be empty"
  }

}

run "validate_required_tags_on_iam_role" {
  command = plan

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "cost-centre")
    error_message = "cost-centre tag must be present on IAM Role"
  }

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "account-code")
    error_message = "account-code tag must be present on IAM Role"
  }

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "portfolio-id")
    error_message = "portfolio-id tag must be present on IAM Role"
  }

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "project-id")
    error_message = "project-id tag must be present on IAM Role"
  }

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "service-id")
    error_message = "service-id tag must be present on IAM Role"
  }

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "environment-type")
    error_message = "environment-type tag must be present on IAM Role"
  }

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "owner-business")
    error_message = "owner-business tag must be present on IAM Role"
  }

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "budget-holder")
    error_message = "budget-holder tag must be present on IAM Role"
  }

  assert {
    condition     = contains(keys(aws_iam_role.this.tags), "source-repo")
    error_message = "source-repo tag must be present on IAM Role"
  }
}

