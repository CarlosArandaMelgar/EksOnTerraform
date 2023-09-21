terraform {
  backend "s3" {
    bucket = "acc-eks-terraform-state"
    key = "03-k8s-utils/terraform.tfstate"
    region = "us-east-1"
  }
}