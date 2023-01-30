variable "prefix" {
  type = string
}

variable "repository_read_write_access_arns" {
  type    = list(string)
  default = []
}
