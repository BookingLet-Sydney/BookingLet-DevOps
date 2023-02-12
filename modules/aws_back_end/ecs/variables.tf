variable "prefix" {
  type = string

}


variable "image_uri" {
  type = string
}


variable "task_role_arn" {
  type = string
}


variable "execution_role_arn" {
  type = string
}


variable "env_s3_arn" {
  type = string
}

variable "containerPort" {
  type = number
}

variable "memoryReservation" {
  type = number
}
variable "target_group_id" {
  type = string
}

variable "cluster_sg_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}
