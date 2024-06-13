resource "aws_s3_bucket" "b" {
 bucket = "dev_s3_bucket"
 acl    = "public"

 tags = {
   Name        = "Environment"
   Environment = "Dev"
 }
}

resource "aws_athena_database" "example" {
  name   = "my_athena_database"
  bucket = aws_s3_bucket.b.name
}
