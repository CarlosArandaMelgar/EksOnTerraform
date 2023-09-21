terraform {
  backend "s3" {
    bucket = "acc-eks-terraform-state"
    key = "04-k8s-resources/terraform.tfstate"
    region = "us-east-1"
  }
}