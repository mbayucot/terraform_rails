variable "region" {
  type    = string
}

variable "vpc" {
  type    = string
}

variable "subnets" {
  type    = list(string)
}

variable "security_group" {
  type    = string
}

variable "elb_name" {
  type    = string
}

variable "target_group_name" {
  type    = string
}

variable "cluster" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "lb_healthcheck_path" {
  type    = string
}

variable "desired_count" {
  type    = string
}

variable "iam_role" {
  type    = string
}