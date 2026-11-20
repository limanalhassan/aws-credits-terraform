# Activity (GUESS): Launch an Amazon EC2 instance (US$20)
# --------------------------------------------------------
# The 6th activity in your screenshot is hidden under the macOS dock, so
# this is a best-guess match ("Launch an Amazon EC2 instance" was in the
# classic 5-activity list). If your 6th activity is actually something
# else, set ec2_create=false in terraform.tfvars to skip this, and tell
# me the real activity so I can swap it.
#
# This instance costs about US$0.0104/hour. Stop or destroy it as soon
# as the activity flips to Completed.

data "aws_ami" "al2023" {
  count       = var.ec2_create ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_security_group" "ec2" {
  count       = var.ec2_create ? 1 : 0
  name        = "${var.name_prefix}-ec2-sg"
  description = "No inbound, all egress. Nothing to SSH to."
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  count                       = var.ec2_create ? 1 : 0
  ami                         = data.aws_ami.al2023[0].id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.ec2[0].id]
  associate_public_ip_address = false

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  user_data = <<-EOT
    #!/bin/bash
    echo "launched at $(date -u)" > /var/log/launched-at.txt
  EOT

  tags = {
    Name = "${var.name_prefix}-ec2"
  }
}
