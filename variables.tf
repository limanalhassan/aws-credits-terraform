variable "region" {
  description = "AWS region. Pick one with full Bedrock coverage. us-east-1 is the safe default."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Named profile in ~/.aws/credentials. Empty string uses the default profile or env vars."
  type        = string
  default     = "default"
}

variable "project_tag" {
  description = "Tag applied to every resource so you can find and clean them up later."
  type        = string
  default     = "explore-aws-credits"
}

variable "name_prefix" {
  description = "Short prefix used in resource names. Keep it DNS-safe (lowercase, hyphens)."
  type        = string
  default     = "explore"
}

variable "budget_amount_usd" {
  description = "Monthly AWS Budget cap in USD. Just needs to exist for the activity, 10 USD is plenty."
  type        = number
  default     = 10
}

variable "budget_alert_email" {
  description = "Email address that receives the budget alert. REQUIRED. Set in terraform.tfvars."
  type        = string
  default     = "liman@linux.com"
}

variable "db_name" {
  description = "Initial database name inside the RDS instance."
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the RDS instance."
  type        = string
  default     = "appuser"
}

variable "ec2_create" {
  description = "Set true to create the EC2 instance (if 'Launch an EC2 instance' is one of your activities)."
  type        = bool
  default     = true
}
