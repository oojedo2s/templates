terraform {
  backend "gcs" {
    bucket = "my-test-storage"
    prefix = "test-terraform"
  }
}