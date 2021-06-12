variable "aws_region" {
    type = "string"
    default = "eu-west-1"
}

variable "bucket_name_prefix" {
    type = "string"
    default =""
}


variable "dist_aliases" {
  default = []
}
variable "tags" {
  default = {}
}