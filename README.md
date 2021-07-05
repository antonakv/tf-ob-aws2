# tf-ob-aws2

This manual is dedicated to create Amazon AWS resources using terraform.

on AWS create VPC create 2 subnets, one for public network, one for private network create internet gw and connect to 
public network create nat gateway, and connect to private network create ec2 instance without public ip, only private 
subnet create a LB (check Application Load Balancer or Network Load Balancer) publish a service over LB, ie nginx

## Requirements

- Hashicorp terraform recent version installed
[Terraform installation manual](https://learn.hashicorp.com/tutorials/terraform/install-cli)

- git installed
[Git installation manual](https://git-scm.com/download/mac)

- Amazon AWS account credentials saved in .aws/credentials file
[Configuration and credential file settings](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

## Preparation 
- Clone git repository. 

```bash
git clone https://github.com/antonakv/tf-ob-aws2.git
```

Expected command output looks like this:

```bash
Cloning into 'tf-ob-aws2'...
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 12 (delta 1), reused 3 (delta 0), pack-reused 0
Receiving objects: 100% (12/12), done.
Resolving deltas: 100% (1/1), done.
```

- Change folder to tf-ob-aws1

```bash
cd tf-ob-aws1
```

- Create file terraform.tfvars with following contents

```
key_name      = "PUT_YOUR_EXISTING_KEYNAME_HERE"
ami           = "ami-05f7491af5eef733a" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
instance_type = "t2.medium"
region        = "eu-central-1"
cidr_vpc      = "10.5.0.0/16"
cidr_subnet1  = "10.5.1.0/24"
cidr_subnet2  = "10.5.2.0/24"
cidr_subnet3  = "10.5.3.0/24"
cidr_subnet4  = "10.5.4.0/24"

```