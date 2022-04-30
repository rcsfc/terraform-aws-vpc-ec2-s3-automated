provider "aws" {
    region = "us-east-1"
}

module "vpc-ec2-s3-automated" {
  source = "github.com/rcsfc/terraform-aws-vpc-ec2-s3-automated//modules/vpc-ec2-s3-automated"
  instance_type = var.instance_type
  availability_zone = var.availability_zone
  CHANGEME_key_path = var.CHANGEME_key_path
  bucket_prefix = var.bucket_prefix
}
