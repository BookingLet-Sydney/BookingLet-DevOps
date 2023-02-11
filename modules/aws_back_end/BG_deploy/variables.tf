variable "prod_traffic_listener_arn" {
  type = list(string)
  default =[]
}
variable "blue_tg_name" {
  type = string
  default = "0"
}
variable "green_tg_name" {
  type = string
  default = "0"
}