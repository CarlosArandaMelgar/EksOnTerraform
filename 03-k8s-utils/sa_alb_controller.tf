resource "kubernetes_service_account_v1" "sa_aws_load_balancer_controller"{
  metadata {
    name = "sa_ws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
        "eks.amazonaws.com/role-arn" = data.terraform_remote_state.eks.outputs.load_balancer_controller_iam_role_arn
    }
  }
}