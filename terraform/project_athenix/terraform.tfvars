s3_buckets = {
  bucket_01 = {
    bucket_name = "projawsprods3bucket01"
  force_destroy = false }
  bucket_02 = {
    bucket_name = "projawsprods3bucket02"
  force_destroy = false }
}

custom_tags = {
  "Env"             = "prod"
  "ApplicationName" = "Athenix-app"
  "ApplicationId"   = "101"
}