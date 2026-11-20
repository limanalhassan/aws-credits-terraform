# Activity: Create a web app using AWS Lambda (US$20)
# -----------------------------------------------------
# A Lambda with a Function URL is the smallest thing AWS will accept as a "web
# app using Lambda" and the Function URL costs nothing until it is invoked.

data "archive_file" "webapp" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda/function.zip"
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.name_prefix}-lambda-exec"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "webapp" {
  function_name    = "${var.name_prefix}-webapp"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.webapp.output_path
  source_code_hash = data.archive_file.webapp.output_base64sha256
  timeout          = 10
  memory_size      = 128
}

resource "aws_lambda_function_url" "webapp" {
  function_name      = aws_lambda_function.webapp.function_name
  authorization_type = "NONE"

  cors {
    allow_origins = ["*"]
    allow_methods = ["GET"]
  }
}
