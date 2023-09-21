data "terraform_remote_state" "vpc" {
    backend = "s3"

    config = {
      bucket = "acc-eks-terraform-state"
      key = "01-vpc/terraform.tfstate"
      region = "us-east-1"
    }
}

