resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/chatbot-sample-lambda"
  retention_in_days = 7
}

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

resource "aws_cloudwatch_metric_alarm" "default" {
  alarm_name          = "ErrorFromChatbotSampleLambdaAlarm"
  alarm_description   = "This metric monitors the error from chatbot sample lambda"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  namespace           = aws_cloudwatch_log_metric_filter.default.metric_transformation[0].namespace
  metric_name         = aws_cloudwatch_log_metric_filter.default.metric_transformation[0].name
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions       = [aws_sns_topic.default.arn]
}
