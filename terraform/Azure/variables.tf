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