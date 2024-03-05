variable "env" {
  description = "Use this variable to customize names to identify resources to this template"
  default     = "dev"
}

variable "region" {
  description = "The region from which this module will be executed.    "
  type        = string
  default     = "us-east-1"
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-\\d", var.region))
    error_message = "Variable var: region is not valid."
  }
}


variable "custom_tags" {
  type = map(string)
  default = {
    "Env"             = "prod"
    "ApplicationName" = "Athenix-app"
    "ApplicationId"   = "101"
  }
}

variable "iam_roles" {
  description = "iam roles"
}

variable "iam_policies" {
  description = "Iam policies"
}


variable "account_id" {
  description = "Aws Account id"
  type        = string

}

variable "layers" {
  description = "Aws Account id"
  type        = list(string)

  default = [
    "bronze",
    "silver",
    "gold",
    "config"
  ]
}

# RDS Modules variable
variable "cluster_identifier" {
  description = "cluster name identifier"
  type        = string
}

variable "db_engine" {
  description = "rds cluster db engine"
  type        = string
}

variable "engine_mode" {
  description = "rds cluster db engine mode"
  type        = string
}
variable "engine_version" {
  description = "rds cluster db engine version"
  type        = string
}
variable "db_name" {
  description = "database name"
  type        = string
}
variable "master_username" {
  description = "master username of database"
  type        = string
}
variable "master_password" {
  description = "master password of database"
  type        = string
}
variable "backup_retention_period" {
  description = "wretention period of rds db data"
  type        = number
}

variable "skip_final_snapshot" {
  description = "value to skip final sanpshot of db before deletion"
  type        = bool
}

variable "rds_cluster_instances" {
  description = "Aws rds cluster instances"
}

variable "subnet_ids" {
  description = "subnet ids in which rds cluster to be deployed"
  type        = list(string)
}

variable "max_scale_capacity" {
  description = "Aws rds maximum scale capacity"
  type        = number
}

variable "min_scale_capacity" {
  description = "Aws rds minimum scale capacity"
  type        = number
}

variable "deletion_protection" {
  description = "Aws rds delete protection "
  type        = bool

}

variable "lf_permissions" {
  description = "Lake formation permissions"

}

variable "glue_crawler_details" {
  description = "glue crawler details"
}

variable "glue_job_details" {
  description = "glue jobs details"
}

variable "lf_register" {
  description = "lake formation register location"
}