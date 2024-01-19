data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "terraform-backend-full-app"
    key = "state/networking/terraform.tfstate"
    region = "us-east-1"
  }
}