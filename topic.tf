# AWSの通知を送るSNSトピックを作成するリソース
resource "aws_sns_topic" "default" {
  # SNSトピックの名前
  name = "terraform-chatbot-sample-sns-topic"
}
