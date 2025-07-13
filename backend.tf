terraform {
  backend "s3" {
    bucket       = "var.s3_bucket_name"
    key          = "usecase3-4/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
