

data "aws_ami" "al2023_arm64" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-minimal-*-arm64"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

# trivy:ignore:AVD-AWS-0131/
resource "aws_instance" "community_demo" {
  instance_type = "t4g.nano"
  # instance_type = var.instance_type
  ami           = data.aws_ami.al2023_arm64.id

  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    "Project" = "",
    "Team"    = ""
  }
}
