variable "prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}
variable "alb_sg_id" {
  type = string

}


variable "subnets" {
  type = list(string)

}
variable "domain_name" {
  type = string
}

variable "route53_zone_id" {
  type = string
}
