
variable "repository_read_write_access_arns" {
  type    = list(string)
  default = []
}

variable "azs" {
  type = list(any)
  default = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}