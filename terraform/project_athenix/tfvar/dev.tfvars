######### S3 Layers ##########

layers = ["bronze", "silver", "gold", "config"]

########## TAGS ########
custom_tags = {
  "Environment"     = "dev-2"
  "ApplicationName" = "Athenix-app"
  "ApplicationId"   = "101"
}

### Account ID ######

account_id = "1234567"

###### IAM ROLES     #########

iam_roles = [{
  name                = "AWSRoleForEC2QlikServer", # Role for  EC2QlikServer
  managed_policies    = ["AdministratorAccess", "AmazonS3FullAccess"],
  trusted_entity_type = "Service"
  trusted_entity_arn  = ["ec2.amazonaws.com"]
  },
  { name                = "AWSRoleGlue", # Role for  GLue
    managed_policies    = ["AWSGlueConsoleFullAccess", "AdministratorAccess", "AWSLakeFormationDataAdmin"],
    trusted_entity_type = "Service"
    trusted_entity_arn  = ["glue.amazonaws.com"]
  },
  { name                = "AWSRoleForRDS", # Role for RDS
    managed_policies    = ["AmazonRDSDataFullAccess"],
    trusted_entity_type = "Service"
    trusted_entity_arn  = ["rds.amazonaws.com", "s3.amazonaws.com"]
  },
  { name                = "AWSRoleForJitender", # Role for Jitender
    managed_policies    = ["AdministratorAccess"],
    trusted_entity_type = "AWS"
    trusted_entity_arn  = ["arn:aws:iam::767398085552:user/jitender"]
  }
]



########### IAM POLICY  #################

iam_policies = [
  {
    name      = "AWSEc2Policy",
    actions   = ["ec2:Describe*", "kms:Decrypt"],
    effect    = "Allow",
    resources = ["*", "arn:aws:ssm:*:*:parameter/mypolicy"]
  }
]


# GLUE CRAWLER SERVICE

glue_crawler_details = [{
  catalog_db_name = "ingest"
  data_location   = "s3://athenixbucketraw/bronze/ingest/player-details/"
  crawler_name    = "len-ingest-crawler"
}]

# GLUE JOBS 

glue_job_details = [{
  glue_job_name       = "len-glue-job"
  job_script_location = "s3://athenixbucketraw/config/main.py"
  max_capacity        = 20
  command_name        = "len-job-script-01"
  glue_version        = "4.0"

}]

#DB Service

cluster_identifier = "athenix-rds-postgres-cluster"
db_engine          = "aurora-postgresql"
engine_mode        = "provisioned"
engine_version     = 14.6
db_name            = "sample"
master_username    = "admin_birla"
master_password    = "Admin12345"

deletion_protection = false

max_scale_capacity = 1
min_scale_capacity = 0.5

subnet_ids              = ["subnet-0ebafbdbc3d729c44", "subnet-0c0925402a21547eb"]
backup_retention_period = 7
skip_final_snapshot     = true

rds_cluster_instances = [
  {
    instance_identifier = "rds-db-instance-01"
    instance_class      = "db.serverless"
    publicly_accessible = false
  },
  {
    instance_identifier = "rds-db-instance-02"
    instance_class      = "db.serverless"
    publicly_accessible = false
  }
]
<<<<<<< HEAD:terraform/project_athenix/terraform.tfvars


#Lake Formation

lf_register = {
  bucket_arn = "arn:aws:s3:::athenixbucketraw"
}

lf_permissions = [{
  lake_permissions = ["ALL", "CREATE_TABLE", "ALTER", "DROP"]
  db_name          = "ingest"
}]

=======
>>>>>>> ad09bc87b651aaa10ec0fed15048d58853036fd2:terraform/project_athenix/tfvar/dev.tfvars
