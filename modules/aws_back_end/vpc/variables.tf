variable "prefix" {
  type = string
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"

}

variable "enable_nat_gateway" {
  default = false
}
variable "enable_vpn_gateway" {
  default = false
}

variable "azs" {
  type    = list(any)
  default = []
}

variable "private_subnets" {
  type    = list(any)
  default = []
}

variable "public_subnets" {
  type    = list(string)
  default = []
}
