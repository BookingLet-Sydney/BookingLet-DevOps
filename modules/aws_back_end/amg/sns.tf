resource "aws_sns_topic" "user_updates" {
  name = "${var.prefix}--${terraform.workspace}-grafana"
}