include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/aws/apps/demo"
}

inputs = {
  vpc_id                 = "vpc-123456"
  subnet_id              = "subnet-123456"
  vpc_security_group_ids = ["sg-123456"]
  instance_type          = "t3.micro"
  key_name               = "poc-key"
  ami_name               = "demo_image"
  ec2_name               = format("%s-demo-ec2-%s", include.root.locals.prj, include.root.locals.env)
  
}
