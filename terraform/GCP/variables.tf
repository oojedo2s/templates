variable "project" {
  description = "My project'S ID"
  type        = string
  default     = "test-project-id"
}

variable "region" {
  description = "My project's region"
  type        = string
  default     = "europe-west3"
}

variable "region_zone" {
  description = "My project's zone"
  type        = string
  default     = "europe-west3-c"
}

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

variable "vpc_ip_addr" {
  description = "The ip address of the subnetwork"
  type        = string
  default     = "10.10.0.0/24"
}

variable "vpc_secondary_ip_addr" {
  description = "The secondary ip address range for testing"
  type = map(object({
    secondary_ip_addr = object({
      range_name    = string
      ip_cidr_range = string
    })
  }))
  default = {
    vpc-net1 = {
      secondary_ip_addr = {
        net_name      = "net1"
        ip_cidr_range = "10.11.0.0/16"
      }
    }
    vpc-net2 = {
      secondary_ip_addr = {
        net_name      = "net2"
        ip_cidr_range = "10.13.0.0/27"
      }
    }
  }

  ###Example usage: first_net_name = var.vpc_secondary_ip_addr.vpc-net1.secondary_ip_addr.net_name
}

variable "vm_name" {
  default = ["server1", "server2"]
}

variable "image" {
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "machine_type" {
  type = map(any)
  default = {
    dev  = "n1-standard-1"
    prod = "n1-standard-4"
  }
}