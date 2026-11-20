output "lambda_function_url" {
  description = "Open this in a browser. It should print 'Hello, world'."
  value       = aws_lambda_function_url.webapp.function_url
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.app.name
}

output "rds_endpoint" {
  value = aws_db_instance.app.address
}

output "rds_master_password" {
  description = "Random password Terraform generated for the RDS master user."
  value       = random_password.db.result
  sensitive   = true
}

output "budget_name" {
  value = aws_budgets_budget.monthly_cost.name
}

output "ec2_instance_id" {
  value = var.ec2_create ? aws_instance.app[0].id : "ec2_create=false; no instance created"
}

output "bedrock_playground_url" {
  description = "Open this, pick Amazon Nova Lite, send a prompt. The one activity Terraform cannot do."
  value       = "https://console.aws.amazon.com/bedrock/home?region=${var.region}#/playground"
}
