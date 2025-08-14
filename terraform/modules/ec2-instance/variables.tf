variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "security_groups" {
  type = list(string)
}
variable "user_data" {}
variable "name" {}
