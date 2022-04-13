data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

data "aws_iam_account_alias" "current" {}

data "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
}
