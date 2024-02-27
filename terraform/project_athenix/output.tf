
output "aws_s3_bucket_keys_output" {
  value = module.aws_s3_mod

}

# locals {
#   bucket={for k, v in module.aws_s3_mod:
#              k=>{ for i in flatten(values(v) ) :
#                    k=>i}

#   }
# }

locals {
  bucket = { for k, v in module.aws_s3_mod :
    k => flatten(values(v))

  }
}

output "local_output" {
  value = local.bucket

}

