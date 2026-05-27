variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "AWS key pair name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instances"
  type        = string
}

variable "frontend_sg_id" {
  description = "Frontend security group ID"
  type        = string
}

variable "backend_sg_id" {
  description = "Backend security group ID"
  type        = string
}

variable "worker_sg_id" {
  description = "Worker security group ID"
  type        = string
}

variable "backend_instance_profile_name" {
  description = "IAM instance profile name for backend EC2"
  type        = string
}