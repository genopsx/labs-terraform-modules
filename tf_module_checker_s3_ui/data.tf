# data "aws_iam_policy_document" "public_s3_policy" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#   }
# }
