variable "region" {
  description = "AWS region"
  default     = "ap-northeast-1"
  type        = string
}

variable "slack_channel_id" {
  description = "value of slack channel id"
  type        = string
}

variable "slack_workspace_id" {
  description = "value of slack workspace id"
  type        = string
}
