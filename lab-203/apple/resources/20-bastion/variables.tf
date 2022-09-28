variable "project" {
  type = string
}

variable "region_code" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "instance_type" {
  description = "instance_type available : [t3.micro,t3.small]"
  type        = string
  default     = "t3.small"
  validation {
    condition     = contains(["t3.micro", "t3.small"], var.instance_type)
    error_message = "Instance type must be t3.micro or t3.small."
  }
}
