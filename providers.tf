provider "aws" {
  region  = var.region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project   = var.project_tag
      ManagedBy = "terraform"
      Purpose   = "explore-aws-credits"
    }
  }
}
