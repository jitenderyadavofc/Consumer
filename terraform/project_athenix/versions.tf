terraform {
  required_version = ">=0.15.1, <2.0.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">=4.9.0, <5.0.0"
     # configuration_aliases = [aws.account_prod, aws.account_qa, aws.account_dev]
    }
  }
}
