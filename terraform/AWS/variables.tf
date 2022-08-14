variable "for-key" {
  description = "Test declaration of ONLY key for for_each"
  type        = list(string)
  default = [
    "foo",
    "bar",
  ]
}

variable "for-key_value" {
  description = "Test declaration of key & value for for_each"
  type        = map(string)
  default = {
    "foo"  = "bar",
    "foo1" = "bar1",
  }
}

variable "region" {
  default     = "eu-central-1"
  description = "Region of aws project"
  type        = string
}

variable "ami" {
  default     = "ami-08d9b803d059dffb8" #Debian 10
  description = "The ami to use"
  type        = string
}

variable "key_path" {
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to ssh public key"
  type        = string
}

variable "instance_names" {
  default = [
    "TunsTest",
    "Awstest"
  ]
  description = "Names to assign to instanes"
  type        = list(string)
}