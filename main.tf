terraform {
  required_version = "~> 1.8.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21"
    }
  }

  backend "s3" {
    bucket = "demo512"
    key    = "terraform/snapshot/state.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "aws_lab"
  region  = "us-east-2"
}

# Data source to get EC2 instance details
data "aws_instance" "target_instance" {
  provider    = aws.aws_lab
  instance_id = "i-00eb66bae41ed8e8e" # Replace with your instance ID
}

# Output instance details for debugging
output "instance_details" {
  value = data.aws_instance.target_instance
}

# Iterate over attached volumes
resource "aws_ebs_snapshot" "volume_snapshots" {
  provider = aws.aws_lab
  for_each = toset(data.aws_instance.target_instance.ebs_block_device[*].volume_id)

  volume_id = each.value
  tags = {
    Name        = "Snapshot-${each.value}"
    CreatedBy   = "Terraform"
    Description = "Snapshot of volume ${each.value} for instance ${data.aws_instance.target_instance.id}"
  }
}

# Output all snapshots
output "snapshots" {
  value = { for k, v in aws_ebs_snapshot.volume_snapshots : k => v.id }
}
