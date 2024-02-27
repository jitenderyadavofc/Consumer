provider "aws" {
  #alias      = "account_prod"
  region     = var.region
  access_key = "AKIA3FLD5QOYL6IF4LOT"
  secret_key = "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"
}

# provider "aws" {
#   alias  = "account_qa"
#   region = var.region
#   assume_role {
#     role_arn = ""
#   }

# }


# provider "aws" {
#   alias  = "account_dev"
#   region = var.region
#   assume_role {
#     role_arn = ""
#   }

# }