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
  source     = "github.com/jitenderyadavofc/Library/terraform/modules/iam/iam-role"

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
  source     = "github.com/jitenderyadavofc/Library/terraform/modules/iam/iam-policies"

  for_each         = { for name, policy in var.iam_policies : name => policy }
  policy_name      = each.value.name
  policy_actions   = each.value.actions
  policy_effect    = each.value.effect
  policy_resources = each.value.resources


  tags = var.custom_tags
}


## GLUE DB Module  ###


module "glue_crawler_mod" {

  source   = "github.com/jitenderyadavofc/Library/terraform/modules/glue/glue-crawler"
  for_each = { for details in var.glue_crawler_details : details.catalog_db_name => details if length(var.glue_crawler_details) > 0 }

  catalog_db_name = each.value.catalog_db_name
  data_location   = each.value.data_location
  crawler_name    = each.value.crawler_name
  glue_role_arn   = local.glue_arn[0]


  tags = var.custom_tags

  depends_on = [module.aws_iam_role_mod]
}

module "glue_jobs_mod" {

  source   = "github.com/jitenderyadavofc/Library/terraform/modules/glue/glue-jobs"
  for_each = { for jobs in var.glue_job_details : jobs.glue_job_name => jobs if length(var.glue_job_details) > 0 }

  glue_role_arn = local.glue_arn[0]

  glue_job_name       = each.value.glue_job_name
  job_script_location = each.value.job_script_location
  max_capacity        = each.value.max_capacity
  command_name        = each.value.command_name
  glue_version        = each.value.glue_version

  tags = var.custom_tags

  depends_on = [module.aws_iam_role_mod, module.glue_crawler_mod]
}


# AWS LakeFormation Module

module "aws_lake_formation_register" {
  source          = "github.com/jitenderyadavofc/Library/terraform/modules/lake-formation/lf-register-location"
  bucket_register = var.lf_register.bucket_arn
}


module "aws_lake_formation_permission" {
  source = "github.com/jitenderyadavofc/Library/terraform/modules/lake-formation/lf-permissions"

  for_each = { for idx, details in var.lf_permissions : idx => details if length(var.lf_permissions) > 0 }

  lake_permissions = each.value.lake_permissions
  principle_arn    = local.glue_arn[0]
  db_name          = each.value.db_name

  depends_on = [module.glue_crawler_mod, module.aws_lake_formation_register]
}






# AppFlow Module

# module "aws_appflow_mod" {
#   source = "./modules/appflow"
# }

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