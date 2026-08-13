module "vpc" {
  source            = "./modules/vpc"
  availability_zone = "${var.aws_region}a"
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
  instance_type = var.instance_type
}