resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/chatbot-sample-lambda"
  retention_in_days = 7
}


