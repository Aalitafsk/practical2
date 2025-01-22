# Terraform script info 
Take snapshots of all volumes attached to an EC2 instance located in a specific region and availability zone.

But you need to pass the instance ID.

# Terraform Commands
terraform init --upgrade 
terraform plan
terraform apply --auto-approve 
terraform destroy --auto-approve

# aws ec2 describe-volumes --filters "Name=attachment.instance-id,Values=i-00eb66bae41ed8e8e" --region us-east-2

# If you output aninstances it will give following details about the ec2 m/c 
instance_details = {
  "ami" = "ami-08970251d20e940b0"
  "arn" = "arn:aws:ec2:us-east-2:826232694389:instance/i-0491c860326630d74"
  "associate_public_ip_address" = true
  "availability_zone" = "us-east-2a"
  "credit_specification" = tolist([
    {
      "cpu_credits" = "standard"
    },
  ])
  "disable_api_termination" = false
  "ebs_block_device" = toset([
    {
      "delete_on_termination" = false
      "device_name" = "/dev/sdf"
      "encrypted" = false
      "iops" = 3000
      "kms_key_id" = ""
      "snapshot_id" = ""
      "tags" = tomap({})
      "throughput" = 125
      "volume_id" = "vol-046d07d83d6a2e582"
      "volume_size" = 1
      "volume_type" = "gp3"
    },
  ])
  "ebs_optimized" = false
  "enclave_options" = tolist([
    {
      "enabled" = false
    },
  ])
  "ephemeral_block_device" = tolist([])
  "filter" = toset(null) /* of object */
  "get_password_data" = false
  "get_user_data" = false
  "host_id" = tostring(null)
  "iam_instance_profile" = ""
  "id" = "i-0491c860326630d74"
  "instance_id" = "i-0491c860326630d74"
  "instance_state" = "running"
  "instance_tags" = tomap(null) /* of string */
  "instance_type" = "t2.micro"
  "ipv6_addresses" = toset([])
  "key_name" = "Ohio"
  "metadata_options" = tolist([
    {
      "http_endpoint" = "enabled"
      "http_put_response_hop_limit" = 2
      "http_tokens" = "required"
      "instance_metadata_tags" = "disabled"
    },
  ])
  "monitoring" = false
  "network_interface_id" = "eni-071ffab35d5e02727"
  "outpost_arn" = ""
  "password_data" = tostring(null)
  "placement_group" = ""
  "placement_partition_number" = tonumber(null)
  "private_dns" = "ip-172-31-7-66.us-east-2.compute.internal"
  "private_ip" = "172.31.7.66"
  "public_dns" = "ec2-3-137-168-96.us-east-2.compute.amazonaws.com"
  "public_ip" = "3.137.168.96"
  "root_block_device" = toset([
    {
      "delete_on_termination" = true
      "device_name" = "/dev/xvda"
      "encrypted" = false
      "iops" = 3000
      "kms_key_id" = ""
      "tags" = tomap({})
      "throughput" = 125
      "volume_id" = "vol-04a4f0f982a8b4f62"
      "volume_size" = 8
      "volume_type" = "gp3"
    },
  ])
  "secondary_private_ips" = toset([])
  "security_groups" = toset([
    "default",
  ])
  "source_dest_check" = true
  "subnet_id" = "subnet-0fef013a3ac192c95"
  "tags" = tomap({
    "Name" = "ohio"
  })
  "tenancy" = "default"
  "user_data" = tostring(null)
  "user_data_base64" = tostring(null)
  "vpc_security_group_ids" = toset([
    "sg-08a453c0d1dbee422",
  ])
}
