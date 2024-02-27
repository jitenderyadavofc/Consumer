
locals {
  glue_arn = [for i, k in module.aws_iam_role_mod["AWSRoleForGlue"] :
  k.arn]
}