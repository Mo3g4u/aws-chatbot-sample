resource "aws_cloudwatch_log_metric_filter" "default" {
  name           = "ErrorFromChatbotSampleLambda"
  pattern        = "Error"
  log_group_name = aws_cloudwatch_log_group.default.name

  metric_transformation {
    name          = "ErrorFromChatbotSampleLambda"
    namespace     = "chatbot-sample-lambda"
    value         = "1"
    unit          = "Count"
    default_value = "0"
  }
}
