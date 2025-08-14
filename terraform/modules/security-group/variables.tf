variable "name" {}
variable "description" {}
variable "vpc_id" {}
variable "allowed_ips" {
  type = list(string)
}
