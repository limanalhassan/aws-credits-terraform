# Activity: Set up a cost budget using AWS Budgets (US$20)
# ---------------------------------------------------------
# AWS Budgets is free for the first two budgets per account. The alert
# fires at 80% of the cap, emailed to budget_alert_email.

resource "aws_budgets_budget" "monthly_cost" {
  name         = "${var.name_prefix}-monthly-cost"
  budget_type  = "COST"
  limit_amount = tostring(var.budget_amount_usd)
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.budget_alert_email]
  }
}
