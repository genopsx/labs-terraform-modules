module "s3_bucket" {
  source                   = "./modules/s3"
  create_bucket            = true
  s3_bucket_name           = var.s3_bucket_name
  object_ownership         = "BucketOwnerPreferred"
  control_object_ownership = true
  force_destroy            = false
  acl                      = "private"
  block_public_policy      = false # Allow public policies
  block_public_acls        = false # Allow public ACLs for objects
  ignore_public_acls       = false # Respect public ACLs
  restrict_public_buckets  = false # Allow public access to the bucket
  tags = {
    Name = var.s3_bucket_name
  }
  website = {
    index_document = "index.html"
  }
}


module "s3_bucket_objects" {
  source = "./modules/object"
  acl    = "public-read"

  for_each = { for file in fileset("source/", "**") : file => file }

  s3_bucket_id          = module.s3_bucket.s3_bucket_id
  s3_bucket_objects_key = each.key

  # Handle both text and binary files correctly
  s3_bucket_objects_content = can(file("source/${each.key}")) ? file("source/${each.key}") : filebase64("source/${each.key}")

  # Dynamically set the Content-Type based on the file extension
  s3_bucket_objects_content_type = lookup(
    {
      ".html" = "text/html",
      ".css"  = "text/css",
      ".js"   = "application/javascript",
      ".json" = "application/json",
      ".png"  = "image/png",
      ".jpeg" = "image/jpeg",
      ".jpg"  = "image/jpeg",
      ".gif"  = "image/gif",
      ".svg"  = "image/svg+xml",
      ".txt"  = "text/plain",
      ".md"   = "text/markdown",
      ".pdf"  = "application/pdf",
      ".zip"  = "application/zip",
      ".xml"  = "application/xml",
      ".webp" = "image/webp",
      ".yaml" = "application/x-yaml",
      ".yml"  = "application/x-yaml",
      ".jfif" = "image/jpeg" # Add this entry for .jfif files
    },
    lower(regex("\\.[^.]+$", each.key)), # Extract file extension in lowercase
    "application/octet-stream"           # Default MIME type
  )

  # Use filemd5 to generate ETag for versioning
  s3_bucket_objects_etag = filemd5("source/${each.key}")

  depends_on = [module.s3_bucket]
}
