locals {
  role_name = "${local.project}SsmRole"
}

resource "aws_iam_role" "ssm" {
  name        = local.role_name
  path        = "/"
  description = "Assume role for EC2 service, intended for EC2-related management."

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = merge(local.tags, { Name = "${local.project}EC2InstanceRole" })

}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm-policy-attach" {
  role       = aws_iam_role.ssm.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

data "aws_iam_policy" "AmazonECS_FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs-policy-attach" {
  role       = aws_iam_role.ssm.name
  policy_arn = data.aws_iam_policy.AmazonECS_FullAccess.arn
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.project}EC2InstanceProfile"
  role = aws_iam_role.ssm.name

  tags = merge(local.tags,
    { Name = "${local.project}EC2InstanceProfile" }
  )
}
