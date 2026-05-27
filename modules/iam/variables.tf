variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "bucket_arn" {
  description = "S3 bucket ARN"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN"
  type        = string
}