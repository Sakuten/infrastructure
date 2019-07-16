resource "aws_s3_bucket_object" "dbgen_archive" {
  bucket = aws_s3_bucket.bucket.id
  key    = "dbgen_archive"
  source = var.dbgen_archive_path
  etag   = filemd5(var.dbgen_archive_path)
}

