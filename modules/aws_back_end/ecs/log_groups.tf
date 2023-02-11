resource "aws_cloudwatch_log_group" "example" {
  name = "/ecs/bkl-syd-app-dev"
  retention_in_days = 30

  lifecycle {
    
  }

}

# resource "aws_cloudwatch_log_stream" "example" {
#   name             = "ecs"
#   log_group_name = "${aws_cloudwatch_log_group.example.name}"
# }