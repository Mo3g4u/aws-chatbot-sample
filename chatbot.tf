# AWS ChatbotのSlackチャンネル設定を作成するリソース
resource "awscc_chatbot_slack_channel_configuration" "default" {
  # Slackチャンネル設定の名前
  configuration_name = "terraform-chatbot-sample-channel"

  # Chatbotが使用するIAMロールのARN
  iam_role_arn = awscc_iam_role.default.arn

  # 通知を送るSlackのチャンネルID
  slack_channel_id = var.slack_channel_id

  # SlackのワークスペースID (AWS Chatbotのコンソール画面で事前に設定が必要)
  slack_workspace_id = var.slack_workspace_id

  # 通知を送るSNSトピックのARNのリスト
  sns_topic_arns = [aws_sns_topic.default.arn]
}

# Chatbotが使用するIAMロールを作成するリソース
resource "awscc_iam_role" "default" {
  # IAMロールの名前
  role_name = "Terraform-ChatBot-Sample-Channel-Role"

  # このポリシーはChatbotサービスがこのロールを引き受けることを許可する
  assume_role_policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "chatbot.amazonaws.com"
        }
      },
    ]
  })

  # このロールにアタッチする管理ポリシーのARN
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSResourceExplorerReadOnlyAccess"]
}
