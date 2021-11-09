terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file(var.ssh_public_key_file)
}

resource "aws_default_vpc" "default" {
  tags = {
    Name : "Default VPC"
  }
}
