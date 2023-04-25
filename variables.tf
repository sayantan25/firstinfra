variable "vpc_cidr" {
  type = string

  default = "10.124.0.0/16"

}

variable "access_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "cloud9_ip" {
  type    = string
  default = "13.50.135.59/32"
}

variable "main_instance_type" {
  type    = string
  default = "t2.micro"

}

variable "main_vol_size" {
  type    = number
  default = 8
}

variable "main_instance_count" {
  type    = number
  default = 1
}

variable "key_name" {
  type = string

}

variable "public_key_path" {
  type = string
}














#variable public_cidr {
#   type = list(string)

#  default = ["10.124.1.0/24", "10.124.3.0/24"]

#}

#variable private_cidr {
#   type = list(string)

#  default = ["10.124.2.0/24", "10.124.4.0/24"]

#}

