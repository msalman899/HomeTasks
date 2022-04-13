
data "aws_iam_policy_document" "s3_writer" {
  statement {
    sid = "S3Access"

    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${module.s3_bucket_qa.s3_bucket_arn}/*",
      "${module.s3_bucket_staging.s3_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_writer" {
  name        = "s3_writer"
  description = "Access to s3 bucket"
  policy      = data.aws_iam_policy_document.s3_writer.json
}

module "s3_writer_irsa" {
  source                       = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                      = "~> v3.8.0"
  create_role                  = true
  role_name                    = "s3-writer"
  provider_urls                = [replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")]
  role_policy_arns             = [aws_iam_policy.s3_writer.arn]
  oidc_subjects_with_wildcards = ["system:serviceaccount:qa:s3_writer","system:serviceaccount:staging:s3_writer"]
  tags = {
    terraform   = "true"
  }
}
