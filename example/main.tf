module "vpc" {
  source = "../"
  vpc_name = "demo"
  aws_region = "eu-west-1"
  aws_zone_1a = "eu-west-1a"
  aws_zone_1b = "eu-west-1b"
  aws_zone_1c = "eu-west-1c"
}
