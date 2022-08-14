terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "test-terraform"
    region = "us-east-1"
  }
}