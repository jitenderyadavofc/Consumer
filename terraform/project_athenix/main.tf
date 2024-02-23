

module "aws_s3_mod" {

    providers = {
      aws.account_prod = aws.account_prod
    }
    source = "github.com/jitenderyadavofc/Library/terraform/modules/s3/s3_v1.0.0"
    s3_buckets=var.s3_buckets

    tags=var.custom_tags
}