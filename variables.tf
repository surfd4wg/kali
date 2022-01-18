variable "ARMKEY" {
  description = "Armor License Key"
  default = "BCDHC-FKWCQ-6J6JP-PBPF4-DWCPM"
}

variable "region" {
  description = "AWS Region to use"  
  default = "us-west-1"
}

variable "avail_zone" {
  description = "AWS Availability zone"
  default = "us-west-1a"
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = "r3dkeywest"
}

variable "public_key_path" {
  description = "Path to the public SSH key you want to bake into the instance."
  default     = "~/.ssh/r3dkeywest.pub"
}

variable "private_key_path" {
  description = "Path to the private SSH key, used to access the instance."
  default     = "~/.ssh/r3dkeywest.pem"
}

variable "project_name" {
  description = "<your org name> terraform ARMOR aws DEMO"
  default     = "terraformR3Dkali"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "kali"
}

variable "access_key" {
  description = "Access Key to AWS account"
  default     = "AKIATTN4NYHYLQYGG2DS"
}

variable "secret_key" {
  description = "Secret Key to AWS account"
  default     = "nQRQJRuYDwOKPEPN8cxxZ3p8ySZcwqcXD9xcnF9F"
}

variable "myname" {
  description = "Default Name tag for AWS Resources"
  default     = "R3Dlocust"
}

variable "mydept" {
  description = "Default Deapartment tag for AWS Resources"
  default     = "DevSecOps Engineering"
}

variable "myorg" {
  description = "Default Organization tag for AWS Resources"
  default     = "https://REDlocust.co"
}

variable "mystack" {
  description = "Default Stack tag for AWS Resources"
  default     = "R3Dlocust Demo"
}

variable "myenv" {
  description = "Default Env tag for AWS Resources"
  default     = "R3Dlocust-Labs"
}

variable "ami_id" {
  description = "Random id generator"
  default     = 1234567890
}

variable "instance_count" {
  description = "number of instances to spin up"
  default = 1
}

variable "INSTANCE_USERNAME" {
  description = "user"
  default = "surfd4wg"
}

variable "INSTANCE_PASSWORD" {
  description = "pass"
  default = "PocketRocketJocket1!="
}
