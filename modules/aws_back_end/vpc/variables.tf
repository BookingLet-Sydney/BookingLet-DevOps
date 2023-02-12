variable "prefix" {
  type = string
}

variable "cidr" {
  type = string
}

variable "single_nat_gateway" {
  type    = bool
  default = true

}
variable "enable_nat_gateway" {
  type    = bool
  default = false
}
variable "enable_vpn_gateway" {
  type    = bool
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
