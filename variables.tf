variable "prefix" {
  type = string
}

variable "count-subnets" {
  type = number
}

variable "cluster_name" {
  type = string
}

variable "retention_in_days" {
  type = number  
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}