provider "aws" {
  region = "ap-southeast-2"

  default_tags {
    tags = {
      Terraform   = "True"
      Environment = terraform.workspace
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.51.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "bkl-syd-tf-backend-fe-bucket"
    key            = "bkl-syd-fe.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "bkl-syd-fe-terraform-lock-table"
  }
}

module "s3" {
  source         = "../../modules/aws_front_end/s3"
  www_domain     = "www.${terraform.workspace}.bookinglet.link"
  non_www_domain = "${terraform.workspace}.bookinglet.link"
}

module "route53" {
  source                  = "../../modules/aws_front_end/route53"
  www_domain              = "www.${terraform.workspace}.bookinglet.link"
  non_www_domain          = "${terraform.workspace}.bookinglet.link"
  www_cdn_domain_name     = module.cdn.www_cdn_domain_name
  www_cdn_zone_id         = module.cdn.www_cdn_zone_id
  non_www_cdn_domain_name = module.cdn.non_www_cdn_domain_name
  non_www_cdn_zond_id     = module.cdn.non_www_cdn_zond_id
}

module "acm" {
  source         = "../../modules/aws_front_end/acm"
  www_domain     = "www.${terraform.workspace}.bookinglet.link"
  non_www_domain = "${terraform.workspace}.bookinglet.link"
}

module "cdn" {
  source                              = "../../modules/aws_front_end/cdn"
  prefix                              = "bkl-syd-fe"
  acm_arn                             = module.acm.acm_arn
  www_domain                          = "www.${terraform.workspace}.bookinglet.link"
  non_www_domain                      = "${terraform.workspace}.bookinglet.link"
  www_bucket_regional_domain_name     = module.s3.www_bucket_regional_domain_name
  non_www_bucket_regional_domain_name = module.s3.non_www_bucket_regional_domain_name
}



