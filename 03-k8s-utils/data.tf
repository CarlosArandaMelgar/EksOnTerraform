data "terraform_remote_state" "vpc" {
   backend = "s3"

    config = {
      bucket = "acc-eks-terraform-state"
      key = "01-vpc/terraform.tfstate"
      region = "us-east-1"
    }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "acc-eks-terraform-state"
    key = "02-eks/terraform.tfstate"
    region = "us-east-1"
  }
}