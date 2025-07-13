resource "aws_instance" "openproject" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.public_subnet_ids[0]


  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt-get install -y docker.io
                sudo systemctl start docker
                sudo systemctl enable docker
                usermod -aG docker ubuntu
                docker run -d -p 80:80 -e OPENPROJECT_SECRET_KEY_BASE=secret -e OPENPROJECT_HTTPS=false openproject/openproject:15.4.1
                EOF

  tags = {
    Name = "UC-03-openproject-instance"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
}