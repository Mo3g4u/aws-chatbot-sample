data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/functions"
  output_path = "${path.module}/outputs/functions.zip"
}

resource "aws_lambda_function" "default" {
  depends_on = [
    aws_cloudwatch_log_group.default,
  ]

  function_name    = "chatbot-sample-lambda"
  runtime          = "python3.12"
  handler          = "main.lambda_handler"
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  role             = aws_iam_role.default.arn

}

resource "aws_iam_role" "default" {
  name               = "chatbot-sample-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json

  inline_policy {
    name   = "chatbot-sample-lambda-policy"
    policy = data.aws_iam_policy_document.default.json
  }
}

data "aws_iam_policy_document" "default" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${aws_cloudwatch_log_group.default.arn}:*",
    ]
  }
}

data "aws_iam_policy_document" "assume_lambda" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
