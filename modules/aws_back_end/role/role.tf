# ecs_task_execution_role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.prefix}-${terraform.workspace}-ecs_task_execution_role"

  assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

}

resource "aws_iam_policy" "ecs_task_role_policy" {
  name        = "${var.prefix}-${terraform.workspace}-ecs_task_role_policy_read_s3_env"
  description = "read-s3 env,work as Task_Role"

  policy = templatefile("${path.module}/policy/ecs_task_role.tftpl",  {
   arn = var.env_s3_arn })
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ])
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "ecs_task_role" {

  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_role_policy.arn
}


# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_inline_policy" {

# }

#######
#ecs_task_role
# resource "aws_iam_role" "ecs_task_role" {
#   name = "${var.prefix}-${terraform.workspace}-ecs_task_role"

#   assume_role_policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "",
#             "Effect": "Allow",
#             "Principal": {
               
#                 "Service": "ecs-tasks.amazonaws.com"
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
# }
# EOF
# }

# resource "aws_iam_policy" "ecs_task_role_policy" {
#   name        = "${var.prefix}-${terraform.workspace}-ecs_task_role_policy"
#   description = "${var.prefix}-${terraform.workspace}-ecs_task_role_policy"

#   policy = templatefile("${path.module}/policy/ecs_task_role.tftpl", {
#     arn = var.env_s3_arn }
#   )
# }

# # resource "aws_iam_role_policy_attachment" "ecs_task_role" {
# #    for_each = toset([
# #     "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
# #   ])
# #   role       = aws_iam_role.ecs_task_role.name
# #   policy_arn = each.value
# # }
# resource "aws_iam_role_policy_attachment" "ecs_task_role" {

#   role       = aws_iam_role.ecs_task_role.name
#   policy_arn = aws_iam_policy.ecs_task_role_policy.arn
# }

