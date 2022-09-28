variable "project" {
  type = string
}

variable "region_code" {
  type = string
}

variable "env" {
  type = string
}

variable "team" {
  type = string
  default = "DevOps"
}

variable "owner" {
  type = string
}

variable "cidr" {
  type = string
}
