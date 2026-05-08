variable "association_config" {
  type = any
}

variable "tags" {
  description = "Tags to be applied to the MSK"
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      contains(keys(var.tags), "account-code"),
      contains(keys(var.tags), "cost-centre"),
      contains(keys(var.tags), "portfolio-id"),
      contains(keys(var.tags), "project-id"),
      contains(keys(var.tags), "service-id"),
      contains(keys(var.tags), "environment-type"),
      contains(keys(var.tags), "owner-business"),
      contains(keys(var.tags), "budget-holder"),
      contains(keys(var.tags), "source-repo")
    ])
    error_message = "Tags must include all mandatory fields."
  }
}

variable "existing_role_arn" {
  type    = string
  default = null
}

variable "role_name" {
  type    = string
  default = null
}

variable "policy_arns" {
  type    = list(string)
  default = []
}
