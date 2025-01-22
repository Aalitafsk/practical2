terraform {
  required_version = "~> 1.8.4"

  required_providers {
    aws = {
      source = "hashicorp/aws"
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
  # profile = "default"
  region  = "us-east-2"
}

/*
# all the subnets in the aws region
data "aws_subnets" "all_subnets" {
	provider = aws.aws_lab
    filter {
    name   = "tag:Name"
    values = ["${var.env}-abc-subnet-1-pub"]
  }
}
*/

# Data source to get EC2 instance details
data "aws_instance" "target_instance" {
  provider = aws.aws_lab
  instance_id = "i-013e6c98aa223a783" # Replace with your instance ID
}

# All attached volumes to the speficed ec2
data "aws_ebs_volumes" "attached_volumes"{
  provider = aws.aws_lab
  filter {
    name   = "attachment.instance-id"
    values = [data.aws_instance.target_instance.id]
  }
}

# Create snapshots for all attached volumes
resource "aws_ebs_snapshot" "volume_snapshots" {
  for_each = tomap({ 
    // for idx, volume_id in data.aws_instance.target_instance.ebs_block_device[*].volume_id : 
    for idx, volume_id in data.aws_instance.target_instance.ebs_block_device.volume_id :
    idx => volume_id
  })

  volume_id = each.value
  tags = {
    Name        = "Snapshot-${each.value}"
    CreatedBy   = "Terraform"
    Description = "Snapshot of volume ${each.value} for instance ${data.aws_instance.target_instance.id}"
  }
}

# Output all attached volumes
output "attached_volumes" {
  value = data.aws_ebs_volumes.attached_volumes.ids
}

# Output all snapshots 
output "all_snapshots" {
  value = aws_ebs_snapshot.volume_snapshots
}

# Output info about instance 
output "instance_info" {
  value = data.aws_instance.target_instance
}