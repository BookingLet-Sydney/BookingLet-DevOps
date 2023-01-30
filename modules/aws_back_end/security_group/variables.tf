variable "prefix" {
  type = string

}
variable "vpc_id" {
  type = string
}
variable "alb_inbound_ports" {
  type    = list(number)
  default = []
}

variable "cluster_inbound_ports" {
  type    = list(number)
  default = []
}
