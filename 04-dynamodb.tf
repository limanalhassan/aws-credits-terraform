# Activity: Create your first Amazon DynamoDB table (US$20)
# ----------------------------------------------------------
# PAY_PER_REQUEST so there is no idle capacity cost. Safe to leave running.

resource "aws_dynamodb_table" "app" {
  name         = "${var.name_prefix}-items"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
