terraform {
  backend "gcs" {
    bucket = "storage-bucket-198111-1"
    prefix = "terraform/state"
  }
}
