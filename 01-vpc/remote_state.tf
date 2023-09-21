terraform {
  backend "s3" {
    bucket = "acc-eks-terraform-state"
    key = "01-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}