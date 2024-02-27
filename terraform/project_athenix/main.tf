### S3 Module  ###

module "aws_s3_mod" {

  # providers = {
  #   aws.account_prod = aws.account_prod
  # }
  source     = "github.com/jitenderyadavofc/Library/terraform/modules/s3"

  for_each    = toset(var.layers)
  bucket_name = "${var.account_id}-athenixlake-${var.custom_tags["Environment"]}-${each.value}"

  tags = var.custom_tags
}

### IAM Roles Module  ###

module "aws_iam_role_mod" {
  # providers = {
  #   aws.account_prod = aws.account_prod
  # }
  source     = "github.com/jitenderyadavofc/Library/terraform/modules/iam"

  for_each            = { for roles in var.iam_roles : roles.name => roles }
  role_name           = each.value.name
  managed_policies    = each.value.managed_policies
  trusted_entity_type = each.value.trusted_entity_type
  trusted_entity_arn  = each.value.trusted_entity_arn


  tags = var.custom_tags
}

### IAM Policy Module  ###

module "aws_iam_policy_mod" {
  # providers = {
  #   aws.account_prod = aws.account_prod
  # }
  source     = "github.com/jitenderyadavofc/Library/terraform/modules/iam-policies"

  for_each         = { for name, policy in var.iam_policies : name => policy }
  policy_name      = each.value.name
  policy_actions   = each.value.actions
  policy_effect    = each.value.effect
  policy_resources = each.value.resources


  tags = var.custom_tags
}


## GLUE DB Module  ###


module "glue_catalog_database_db" {

  source     = "github.com/jitenderyadavofc/Library/terraform/modules/glue"

  catalog_db_name = var.catalog_db_name
  data_location   = var.data_location
  crawler_name    = var.crawler_name
  glue_role_arn   = local.glue_arn[0]

  glue_job_name       = var.glue_job_name
  job_script_location = var.job_script_location
  max_capacity        = var.max_capacity
  command_name        = var.command_name


  tags = var.custom_tags

  depends_on = [module.aws_iam_role_mod]
}


# RDS Module

module "aws_rds_mod" {
 
    source     = "github.com/jitenderyadavofc/Library/terraform/modules/rds"
    cluster_identifier = var.cluster_identifier
    db_engine = var.db_engine
    engine_mode = var.engine_mode
    engine_version = var.engine_version
    subnet_ids = var.subnet_ids

    db_name = var.db_name
    master_username = var.master_username
    master_password = var.master_password
    max_scale_capacity = var.max_scale_capacity
    min_scale_capacity = var.min_scale_capacity
    deletion_protection = var.deletion_protection
    
    backup_retention_period = var.backup_retention_period
    skip_final_snapshot = var.skip_final_snapshot

    rds_cluster_instances = var.rds_cluster_instances
    tags = var.custom_tags
}