data "aws_iam_policy_document" "qa_s3_bucket_policy" {
  statement {
    sid       = "Allow write access to the bucket"
    effect    = "Allow"
    resources = ["${module.s3_bucket_qa.s3_bucket_arn}/*"]
    actions   = ["s3:PutObject"]

    principals {
      type        = "AWS"
      identifiers = [module.s3_writer_irsa.this_iam_role_arn]
    }
  }
}

module "s3_bucket_qa" {
  source                               = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.0.1"
  create_bucket                        = true
  bucket                               = "qa-muhammad-salman-platform-challenge"
  acl                                  = "private"
  attach_public_policy                 = "true"
  block_public_acls                    = "true"
  block_public_policy                  = "true"
  restrict_public_buckets              = "true"
  ignore_public_acls                   = "true"
  lifecycle_rule                       = [
    {
      id      = "cleanup"
      enabled = true

      expiration = {
        days = 1
      }
    }
  ]
  attach_policy                        = true
  policy                               = data.aws_iam_policy_document.qa_s3_bucket_policy.json
  tags                                 = {
    terraform   = "true"
  }
}

data "aws_iam_policy_document" "staging_s3_bucket_policy" {
  statement {
    sid       = "Allow write access to the bucket"
    effect    = "Allow"
    resources = ["${module.s3_bucket_qa.s3_bucket_arn}/*"]
    actions   = ["s3:PutObject"]

    principals {
      type        = "AWS"
      identifiers = [module.s3_writer_irsa.this_iam_role_arn]
    }
  }
}

module "s3_bucket_staging" {
  source                               = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.0.1"
  create_bucket                        = true
  bucket                               = "staging-muhammad-salman-platform-challenge"
  acl                                  = "private"
  attach_public_policy                 = "true"
  block_public_acls                    = "true"
  block_public_policy                  = "true"
  restrict_public_buckets              = "true"
  ignore_public_acls                   = "true"
  lifecycle_rule                       = [
    {
      id      = "cleanup"
      enabled = true

      expiration = {
        days = 1
      }
    }
  ]
  attach_policy                        = true
  policy                               = data.aws_iam_policy_document.staging_s3_bucket_policy.json
  tags                                 = {
    terraform   = "true"
  }
}