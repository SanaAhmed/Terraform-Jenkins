variable "AWS_ACCESS_KEY" {
  default = ""
}

variable "AWS_SECRET_KEY" {
  default = ""
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "instance_username" {
  default = "ubuntu"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "Jenkins_Key"
}

variable "zone" {
  default = "eu-west-1a"
}

variable "instance_type" {
  default = "m4.large"
}

variable "amis" {
  type = "map"

  default = {
    us-east-1 = "ami-2a7d75c0"
    us-west-2 = "ami-2a7d75c0"
    eu-west-1 = "ami-2a7d75c0"
  }
}