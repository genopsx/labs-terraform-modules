
# tflint-ignore: terraform_unused_declarations
data "aws_caller_identity" "current" {} # data.aws_caller_identity.current.account_id
# tflint-ignore: terraform_unused_declarations
data "aws_region" "current" {} # data.aws_region.current.name
