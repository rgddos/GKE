terraform {
  backend "gcs" {
    lock = true
  }
}
