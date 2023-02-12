variable "prefix" {
  type = string
}

variable "cluster_name" {
  type = string
}
variable "service_name" {
  type = string
}


variable "auto_scaling_policy_scaleUp_arn" {
  type = string

}

variable "auto_scaling_policy_scaleDown_arn" {
  type = string

}
variable "high_threshold" {
  type = string
}

variable "low_threshold" {
  type = string
}

variable "evaluation_periods" {
  type = string
}
variable "metric_name" {
  type = string
}
variable "statistic" {
  type = string
}

variable "period" {
  type = string
}
