terraform {
  backend "s3" {
    bucket       = "usecase-3-4-terraform-state"
    key          = "usecase3-4/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
