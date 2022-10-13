resource "aws_iam_role" "main" {
  name               = var.service
  assume_role_policy = data.aws_iam_policy_document.main_assume_role.json
}

data "aws_iam_policy_document" "main_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "main_pull_image" {
  name   = "${var.service}-pull-image"
  role   = aws_iam_role.main.id
  policy = data.aws_iam_policy_document.main_pull_image.json
}

resource "aws_iam_role_policy" "main_publish_logs" {
  count  = local.logs_enabled ? 1 : 0
  name   = "${var.service}-publish-logs"
  role   = aws_iam_role.main.id
  policy = data.aws_iam_policy_document.main_publish_logs.json
}

data "aws_iam_policy_document" "main_pull_image" {
  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::prod-region-starport-layer-bucket/*"
    ]
  }
}

data "aws_iam_policy_document" "main_publish_logs" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "*"
    ]
  }
}