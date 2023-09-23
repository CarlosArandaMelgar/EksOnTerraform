module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "vcc-eks-tf"
  cluster_version = "1.22"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

//Communication between nodes for AWS load Balancer
  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }

  eks_managed_node_groups = {
      group1 = {
        min_size     = 1
        max_size     = 3
        desired_size = 1

        instance_types = ["t3.large"]
      }
    }


  fargate_profiles = {
    fg-developers = {
      name = "fg-developers"
      selectors = [
        {
          namespace = "fg-developers"
        }
      ]
    }
  }

  tags = {
    Environment = "staging"
    Terraform   = "true"
  }

}

# Define el grupo de seguridad adicional en el node_security_group_additional_rules
# resource "aws_security_group" "my_additional_sg" {
#   name        = "my-additional-sg"
#   description = "My additional security group"
#   vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

#   # Agregar reglas de seguridad necesarias aquí
#   # Por ejemplo, para permitir tráfico en el puerto 9443
#   egress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }