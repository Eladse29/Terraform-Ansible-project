resource "aws_iam_role" "backend_role" {
  name = "${var.project_name}-${var.environment}-backend-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "backend_policy" {
  name        = "${var.project_name}-${var.environment}-backend-policy"
  description = "Allows backend EC2 to upload reports to S3 and publish SNS messages"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "${var.bucket_arn}/*"
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish"
        ]
        Resource = var.sns_topic_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backend_attach" {
  role       = aws_iam_role.backend_role.name
  policy_arn = aws_iam_policy.backend_policy.arn
}

resource "aws_iam_instance_profile" "backend_profile" {
  name = "${var.project_name}-${var.environment}-backend-profile"
  role = aws_iam_role.backend_role.name
}