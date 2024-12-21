## IAM Role and Permissions
resource "aws_iam_role" "role_dynamodb" {
  name = "${local.name_prefix}-role-dynamodb"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "policy_dynamodb" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:ListTables"]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:Scan"]
    resources = [aws_dynamodb_table.bookinventory.arn]
  }
}

resource "aws_iam_policy" "policy_dynamodb" {
  name   = "${local.name_prefix}-policy-dynamodb"
  policy = data.aws_iam_policy_document.policy_dynamodb.json
}

resource "aws_iam_role_policy_attachment" "attach_dynamodb" {
  role       = aws_iam_role.role_dynamodb.name
  policy_arn = aws_iam_policy.policy_dynamodb.arn
}

resource "aws_iam_instance_profile" "profile_dynamodb" {
  name = "${local.name_prefix}-profile-dynamodb"
  role = aws_iam_role.role_dynamodb.name
}