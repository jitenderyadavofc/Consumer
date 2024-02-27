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

}

variable "iam_policies" {

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

variable "catalog_db_name" {
  description = "Aws glue catalog db name"
  type        = string

}

variable "data_location" {
  description = "datasource location"
  type        = string

}

variable "crawler_name" {
  description = "Aws glue crawler name"
  type        = string

}

# variable "glue_role_arn" {
#   description = "Aws glue role arn"
#   type        = string

# }

variable "glue_job_name" {
  description = "Aws glue job name"
  type        = string

}

variable "max_capacity" {
  description = "Aws glue job max capacity  DPU"
  type        = number

}

variable "command_name" {
   description = "Aws glue job command"
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

variable "job_script_location" {
  description = "Aws glue job script location"
  type        = string
}


variable "rds_cluster_instances"{
  description = "Aws rds cluster instances"
}

variable "subnet_ids" {
  description = "subnet ids in which rds cluster to be deployed"
  type        = list(string)
}

variable "max_scale_capacity" {
  description = "Aws rds maximum scale capacity"
  type = number
}

variable "min_scale_capacity" {
  description = "Aws rds minimum scale capacity"
  type = number
}

variable "deletion_protection" {  
  description = "Aws rds delete protection "
  type = bool
  
}