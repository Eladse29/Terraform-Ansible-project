resource "aws_instance" "frontend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.frontend_sg_id]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-frontend"
    Environment = var.environment
    Role        = "frontend"
  }
}

resource "aws_instance" "backend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.backend_sg_id]
  associate_public_ip_address = true
  iam_instance_profile = var.backend_instance_profile_name

  tags = {
    Name        = "${var.project_name}-${var.environment}-backend"
    Environment = var.environment
    Role        = "backend"
  }
}

resource "aws_instance" "worker" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.worker_sg_id]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-worker"
    Environment = var.environment
    Role        = "worker"
  }
}