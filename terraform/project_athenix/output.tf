
output "aws_s3_bucket_id_output" {
    value = { 
           for bucket_key, bucket_value in module.aws_s3_mod.s3_buckets:
             bucket_key=>bucket_value.id
    }
     
}


output "aws_s3_bucket_keys_output" {
    value = values(module.aws_s3_mod.s3_buckets)
     
}
