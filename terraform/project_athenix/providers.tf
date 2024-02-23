provider "aws" {
    alias = "account_prod"
    region = var.region
    access_key = "AKIA3Y2WBELOLNCRS4NL"
    secret_key = "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"
  
}

provider "aws" {
    alias = "account_qa"
    region = var.region
    assume_role {
      role_arn = ""
    }
  
}


provider "aws" {
    alias = "account_dev"
    region = var.region
    assume_role {
      role_arn = ""
    }
  
}