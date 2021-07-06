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

- Change folder to tf-ob-aws2

```bash
cd tf-ob-aws2
```

- Create file terraform.tfvars with following contents

```
key_name      = "PUT_YOUR_EXISTING_KEYNAME_HERE"
ami           = "ami-091d856a5f5701931" # Own private AMI with nginx installed, replace with your own
instance_type = "t2.medium"
region        = "eu-central-1"
cidr_vpc      = "10.5.0.0/16"
cidr_subnet1  = "10.5.1.0/24"
cidr_subnet2  = "10.5.2.0/24"
cidr_subnet3  = "10.5.3.0/24"
cidr_subnet4  = "10.5.4.0/24"

```

## Run terraform code

- In the same folder you were before run init


```bash
terraform init
```

Sample result

```bash
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.42.0...
- Installed hashicorp/aws v3.42.0 (self-signed, key ID 34365D9472D7468F)

Partner and community providers are signed by their developers.
If you d like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

- In the same folder you were before run terraform apply

```bash
terraform apply
```

Sample command output

```bash
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_acm_certificate.aws2 will be created
  + resource "aws_acm_certificate" "aws2" {
      + arn                       = (known after apply)
      + domain_name               = "tfe3.anton.hashicorp-success.com"
      + domain_validation_options = [
          + {
              + domain_name           = "tfe3.anton.hashicorp-success.com"
              + resource_record_name  = (known after apply)
              + resource_record_type  = (known after apply)
              + resource_record_value = (known after apply)
            },
        ]
      + id                        = (known after apply)
      + status                    = (known after apply)
      + subject_alternative_names = (known after apply)
      + tags_all                  = (known after apply)
      + validation_emails         = (known after apply)
      + validation_method         = "DNS"
    }

  # aws_acm_certificate_validation.aws2 will be created
  + resource "aws_acm_certificate_validation" "aws2" {
      + certificate_arn = (known after apply)
      + id              = (known after apply)
    }

  # aws_eip.aws2 will be created
  + resource "aws_eip" "aws2" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = (known after apply)
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags_all             = (known after apply)
      + vpc                  = true
    }

  # aws_instance.aws2 will be created
  + resource "aws_instance" "aws2" {
      + ami                                  = "ami-091d856a5f5701931"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = false
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.medium"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "aakulov"
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "aakulov-aws2"
        }
      + tags_all                             = {
          + "Name" = "aakulov-aws2"
        }
      + tenancy                              = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.igw will be created
  + resource "aws_internet_gateway" "igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "aakulov-aws2"
        }
      + tags_all = {
          + "Name" = "aakulov-aws2"
        }
      + vpc_id   = (known after apply)
    }

  # aws_lb.aws2 will be created
  + resource "aws_lb" "aws2" {
      + arn                        = (known after apply)
      + arn_suffix                 = (known after apply)
      + dns_name                   = (known after apply)
      + drop_invalid_header_fields = false
      + enable_deletion_protection = false
      + enable_http2               = true
      + id                         = (known after apply)
      + idle_timeout               = 60
      + internal                   = false
      + ip_address_type            = (known after apply)
      + load_balancer_type         = "application"
      + name                       = "aakulov-aws2"
      + security_groups            = (known after apply)
      + subnets                    = (known after apply)
      + tags_all                   = (known after apply)
      + vpc_id                     = (known after apply)
      + zone_id                    = (known after apply)

      + subnet_mapping {
          + allocation_id        = (known after apply)
          + ipv6_address         = (known after apply)
          + outpost_id           = (known after apply)
          + private_ipv4_address = (known after apply)
          + subnet_id            = (known after apply)
        }
    }

  # aws_lb_listener.aws2 will be created
  + resource "aws_lb_listener" "aws2" {
      + arn               = (known after apply)
      + certificate_arn   = (known after apply)
      + id                = (known after apply)
      + load_balancer_arn = (known after apply)
      + port              = 443
      + protocol          = "HTTPS"
      + ssl_policy        = "ELBSecurityPolicy-2016-08"
      + tags_all          = (known after apply)

      + default_action {
          + order            = (known after apply)
          + target_group_arn = (known after apply)
          + type             = "forward"
        }
    }

  # aws_lb_target_group.aakulov-aws2 will be created
  + resource "aws_lb_target_group" "aakulov-aws2" {
      + arn                                = (known after apply)
      + arn_suffix                         = (known after apply)
      + deregistration_delay               = 300
      + id                                 = (known after apply)
      + lambda_multi_value_headers_enabled = false
      + load_balancing_algorithm_type      = (known after apply)
      + name                               = "aakulov-aws2"
      + port                               = 80
      + preserve_client_ip                 = (known after apply)
      + protocol                           = "HTTP"
      + protocol_version                   = (known after apply)
      + proxy_protocol_v2                  = false
      + slow_start                         = 0
      + tags_all                           = (known after apply)
      + target_type                        = "instance"
      + vpc_id                             = (known after apply)

      + health_check {
          + enabled             = (known after apply)
          + healthy_threshold   = (known after apply)
          + interval            = (known after apply)
          + matcher             = (known after apply)
          + path                = (known after apply)
          + port                = (known after apply)
          + protocol            = (known after apply)
          + timeout             = (known after apply)
          + unhealthy_threshold = (known after apply)
        }

      + stickiness {
          + cookie_duration = (known after apply)
          + cookie_name     = (known after apply)
          + enabled         = (known after apply)
          + type            = (known after apply)
        }
    }

  # aws_lb_target_group_attachment.aakulov-aws2 will be created
  + resource "aws_lb_target_group_attachment" "aakulov-aws2" {
      + id               = (known after apply)
      + target_group_arn = (known after apply)
      + target_id        = (known after apply)
    }

  # aws_nat_gateway.nat will be created
  + resource "aws_nat_gateway" "nat" {
      + allocation_id        = (known after apply)
      + connectivity_type    = "public"
      + id                   = (known after apply)
      + network_interface_id = (known after apply)
      + private_ip           = (known after apply)
      + public_ip            = (known after apply)
      + subnet_id            = (known after apply)
      + tags                 = {
          + "Name" = "aakulov-aws2"
        }
      + tags_all             = {
          + "Name" = "aakulov-aws2"
        }
    }

  # aws_route53_record.aws2 will be created
  + resource "aws_route53_record" "aws2" {
      + allow_overwrite = true
      + fqdn            = (known after apply)
      + id              = (known after apply)
      + name            = "tfe3.anton.hashicorp-success.com"
      + records         = (known after apply)
      + ttl             = 300
      + type            = "CNAME"
      + zone_id         = "Z077919913NMEBCGB4WS0"
    }

  # aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"] will be created
  + resource "aws_route53_record" "cert_validation" {
      + allow_overwrite = true
      + fqdn            = (known after apply)
      + id              = (known after apply)
      + name            = (known after apply)
      + records         = (known after apply)
      + ttl             = 60
      + type            = (known after apply)
      + zone_id         = "Z077919913NMEBCGB4WS0"
    }

  # aws_route_table.aws2-private will be created
  + resource "aws_route_table" "aws2-private" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "aakulov-aws2-private"
        }
      + tags_all         = {
          + "Name" = "aakulov-aws2-private"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.aws2-public will be created
  + resource "aws_route_table" "aws2-public" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "aakulov-aws2-public"
        }
      + tags_all         = {
          + "Name" = "aakulov-aws2-public"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.aws2-private will be created
  + resource "aws_route_table_association" "aws2-private" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.aws2-public will be created
  + resource "aws_route_table_association" "aws2-public" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.aws2-internal-sg will be created
  + resource "aws_security_group" "aws2-internal-sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = -1
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "icmp"
              + security_groups  = []
              + self             = false
              + to_port          = -1
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "aws2-internal-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "aws2-internal-sg"
        }
      + tags_all               = {
          + "Name" = "aws2-internal-sg"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.aws2-lb-sg will be created
  + resource "aws_security_group" "aws2-lb-sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "aws2-lb-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "aws2-lb-sg"
        }
      + tags_all               = {
          + "Name" = "aws2-lb-sg"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.subnet_private will be created
  + resource "aws_subnet" "subnet_private" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "eu-central-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.5.1.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags_all                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.subnet_private1 will be created
  + resource "aws_subnet" "subnet_private1" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "eu-central-1c"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.5.3.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags_all                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.subnet_public will be created
  + resource "aws_subnet" "subnet_public" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "eu-central-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.5.2.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags_all                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.vpc will be created
  + resource "aws_vpc" "vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.5.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "aakulov-aws2"
        }
      + tags_all                         = {
          + "Name" = "aakulov-aws2"
        }
    }

Plan: 22 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + aws_url = "tfe3.anton.hashicorp-success.com"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.vpc: Creating...
aws_acm_certificate.aws2: Creating...
aws_eip.aws2: Creating...
aws_eip.aws2: Creation complete after 0s [id=eipalloc-160dbe28]
aws_acm_certificate.aws2: Creation complete after 7s [id=arn:aws:acm:eu-central-1:267023797923:certificate/8d45cf88-5232-4e4c-b045-d303f05a5033]
aws_acm_certificate_validation.aws2: Creating...
aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"]: Creating...
aws_vpc.vpc: Still creating... [10s elapsed]
aws_vpc.vpc: Creation complete after 12s [id=vpc-0ffea95115581c6c6]
aws_internet_gateway.igw: Creating...
aws_subnet.subnet_private1: Creating...
aws_subnet.subnet_public: Creating...
aws_subnet.subnet_private: Creating...
aws_lb_target_group.aakulov-aws2: Creating...
aws_security_group.aws2-lb-sg: Creating...
aws_security_group.aws2-internal-sg: Creating...
aws_subnet.subnet_public: Creation complete after 1s [id=subnet-093aac4775458c7ff]
aws_subnet.subnet_private1: Creation complete after 1s [id=subnet-057e0957dc970d992]
aws_subnet.subnet_private: Creation complete after 1s [id=subnet-0ac67cf5758f9d4c5]
aws_lb_target_group.aakulov-aws2: Creation complete after 1s [id=arn:aws:elasticloadbalancing:eu-central-1:267023797923:targetgroup/aakulov-aws2/f3aedc4c37bcbb8b]
aws_internet_gateway.igw: Creation complete after 1s [id=igw-06b4b22fea4e6bff7]
aws_nat_gateway.nat: Creating...
aws_route_table.aws2-public: Creating...
aws_security_group.aws2-lb-sg: Creation complete after 2s [id=sg-095b6866fe0047c7d]
aws_lb.aws2: Creating...
aws_security_group.aws2-internal-sg: Creation complete after 3s [id=sg-0f1a6d1fc419d4eb8]
aws_route_table.aws2-public: Creation complete after 2s [id=rtb-0eaba1fd6c85e04b1]
aws_instance.aws2: Creating...
aws_route_table_association.aws2-public: Creating...
aws_route_table_association.aws2-public: Creation complete after 0s [id=rtbassoc-055a5d0f4a6a4de0d]
aws_acm_certificate_validation.aws2: Still creating... [10s elapsed]
aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"]: Still creating... [10s elapsed]
aws_nat_gateway.nat: Still creating... [10s elapsed]
aws_lb.aws2: Still creating... [10s elapsed]
aws_acm_certificate_validation.aws2: Creation complete after 18s [id=2021-07-05 14:07:21 +0000 UTC]
aws_instance.aws2: Still creating... [10s elapsed]
aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"]: Still creating... [20s elapsed]
aws_nat_gateway.nat: Still creating... [20s elapsed]
aws_lb.aws2: Still creating... [20s elapsed]
aws_instance.aws2: Still creating... [20s elapsed]
aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"]: Still creating... [30s elapsed]
aws_nat_gateway.nat: Still creating... [30s elapsed]
aws_lb.aws2: Still creating... [30s elapsed]
aws_instance.aws2: Still creating... [30s elapsed]
aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"]: Still creating... [40s elapsed]
aws_nat_gateway.nat: Still creating... [40s elapsed]
aws_lb.aws2: Still creating... [40s elapsed]
aws_instance.aws2: Still creating... [40s elapsed]
aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"]: Still creating... [50s elapsed]
aws_instance.aws2: Creation complete after 43s [id=i-0c0a39a9d6ed8aff0]
aws_lb_target_group_attachment.aakulov-aws2: Creating...
aws_lb_target_group_attachment.aakulov-aws2: Creation complete after 0s [id=arn:aws:elasticloadbalancing:eu-central-1:267023797923:targetgroup/aakulov-aws2/f3aedc4c37bcbb8b-20210705140759969300000002]
aws_nat_gateway.nat: Still creating... [50s elapsed]
aws_lb.aws2: Still creating... [50s elapsed]
aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"]: Still creating... [1m0s elapsed]
aws_nat_gateway.nat: Still creating... [1m0s elapsed]
aws_route53_record.cert_validation["tfe3.anton.hashicorp-success.com"]: Creation complete after 1m7s [id=Z077919913NMEBCGB4WS0__f706da4cad7adeb580f9da519a94d5b8.tfe3.anton.hashicorp-success.com._CNAME]
aws_lb.aws2: Still creating... [1m0s elapsed]
aws_nat_gateway.nat: Still creating... [1m10s elapsed]
aws_lb.aws2: Still creating... [1m10s elapsed]
aws_nat_gateway.nat: Still creating... [1m20s elapsed]
aws_lb.aws2: Still creating... [1m20s elapsed]
aws_nat_gateway.nat: Still creating... [1m30s elapsed]
aws_lb.aws2: Still creating... [1m30s elapsed]
aws_nat_gateway.nat: Creation complete after 1m36s [id=nat-0bcec2b3857ae2cb7]
aws_route_table.aws2-private: Creating...
aws_route_table.aws2-private: Creation complete after 1s [id=rtb-09bd6f9578f0b1973]
aws_route_table_association.aws2-private: Creating...
aws_route_table_association.aws2-private: Creation complete after 1s [id=rtbassoc-00f8d397c4ad809f7]
aws_lb.aws2: Still creating... [1m40s elapsed]
aws_lb.aws2: Still creating... [1m50s elapsed]
aws_lb.aws2: Still creating... [2m0s elapsed]
aws_lb.aws2: Creation complete after 2m3s [id=arn:aws:elasticloadbalancing:eu-central-1:267023797923:loadbalancer/app/aakulov-aws2/fdd85652434d6851]
aws_route53_record.aws2: Creating...
aws_lb_listener.aws2: Creating...
aws_lb_listener.aws2: Creation complete after 1s [id=arn:aws:elasticloadbalancing:eu-central-1:267023797923:listener/app/aakulov-aws2/fdd85652434d6851/a47b8cb0628740c4]
aws_route53_record.aws2: Still creating... [10s elapsed]
aws_route53_record.aws2: Still creating... [20s elapsed]
aws_route53_record.aws2: Still creating... [30s elapsed]
aws_route53_record.aws2: Creation complete after 37s [id=Z077919913NMEBCGB4WS0_tfe3.anton.hashicorp-success.com_CNAME]

Apply complete! Resources: 22 added, 0 changed, 0 destroyed.

Outputs:

aws_url = "tfe3.anton.hashicorp-success.com"
```

