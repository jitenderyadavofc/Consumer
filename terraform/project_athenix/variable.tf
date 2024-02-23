variable "env" {
  description = "Use this variable to customize names to identify resources to this template"
  default = "dev"
}

variable "region" {
  description = "The region from which this module will be executed.    "
  type        = string
  default = "us-east-1"
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-\\d", var.region))
    error_message = "Variable var: region is not valid."
  }
}

variable "s3_buckets" {
  type = map(object({
    bucket_name = string
    force_destroy=bool
  }))
}

variable "custom_tags" {
  type = map(string)
  default = {
    "Env"="prod"
    "ApplicationName"="Athenix-app"
    "ApplicationId"="101"
  }
}