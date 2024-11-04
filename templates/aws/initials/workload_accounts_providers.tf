# Configure the dev AWS Provider
provider "aws" {
  alias  = "if2-dev"
  region = "eu-central-1"
  assume_role {
    role_arn = local.terragrunt_environments["dev"]["workload_role_arn"]
  }
  default_tags {
    tags = {
      "Owner"       = "Storm Mobility"
      "Project"     = "ImageFactory2"
      "Environment" = "Development"
    }
  }
}

# Configure the prod AWS Provider
provider "aws" {
  alias  = "if2-prd"
  region = "eu-central-1"
  assume_role {
    role_arn = local.terragrunt_environments["prd"]["workload_role_arn"]
  }
  default_tags {
    tags = {
      "Owner"       = "Storm Mobility"
      "Project"     = "ImageFactory2"
      "Environment" = "Production"
    }
  }
}
