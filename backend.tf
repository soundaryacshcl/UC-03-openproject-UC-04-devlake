terraform {
  backend "s3" {
    bucket       = "usecase-5-terraform-state-backup"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
