data "aws_ami" "demo_packer_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = [
      var.ami_name,
    ]
  }
}