resource "helm_release" "load_balancer_controller" {
  name             = "load-balancer-ingress-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  namespace        = "kube-system"

  set {
    name  = "clusterName"
    value = data.terraform_remote_state.eks.outputs.cluster_id
  }
  set {
    name  = "serviceAccount.create"
    value = false
  }
  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account_v1.sa_aws_load_balancer_controller.metadata.0.name
  }
  set {
    name  = "vpcId"
    value = data.terraform_remote_state.vpc.outputs.vpc_id
  }
}

