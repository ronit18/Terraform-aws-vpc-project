# Terraform-aws-vpc-project


## Terraform project for a VPC with public and private subnets and two EC2 instances

This repository contains Terraform code for creating a VPC on AWS with the following components:

- VPC: Defined with a configurable CIDR block.
- Subnets: One public and one private subnet within the VPC, each with its own CIDR block and availability zone.
- Internet Gateway: Enables internet access for resources in the public subnet.
- NAT Gateway: Allows private instances to access the internet through the public subnet.
- Route Tables: One for each subnet, directing traffic accordingly.
- Security Group: Configured to allow HTTP and SSH inbound traffic for instances in both subnets.
- EC2 Instances: Two instances (one public, one private) launched with the specified AMI ID and instance type.
