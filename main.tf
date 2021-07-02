provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "aakulov-aws2"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnet1
  availability_zone = "eu-central-1b"
}

resource "aws_subnet" "subnet_private1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnet3
  availability_zone = "eu-central-1c"
}

resource "aws_subnet" "subnet_public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnet2
  availability_zone = "eu-central-1a"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "aakulov-aws2"
  }
}

resource "aws_eip" "aws2" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.aws2.id
  subnet_id     = aws_subnet.subnet_public.id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = "aakulov-aws2"
  }
}

resource "aws_route_table" "aws2-private" {
  vpc_id = aws_vpc.vpc.id


  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "aakulov-aws2-private"
  }
}

resource "aws_route_table" "aws2-public" {
  vpc_id = aws_vpc.vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "aakulov-aws2-public"
  }
}

resource "aws_route_table_association" "aws2-private" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.aws2-private.id
}

resource "aws_route_table_association" "aws2-public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.aws2-public.id
}

resource "aws_security_group" "aakulov-aws2" {
  vpc_id = aws_vpc.vpc.id
  name   = "aakulov-aws2"
  tags = {
    Name = "aakulov-aws2"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "aws2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.aakulov-aws2.id]
  subnet_id                   = aws_subnet.subnet_private.id
  associate_public_ip_address = true
  user_data                   = file("scripts/install_nginx.sh")
  tags = {
    Name = "aakulov-aws2"
  }
}

resource "aws_route53_record" "aws2" {
  zone_id         = "Z077919913NMEBCGB4WS0"
  name            = "tfe3.anton.hashicorp-success.com"
  type            = "CNAME"
  ttl             = "300"
  records         = [aws_lb.aws2.dns_name]
  allow_overwrite = true
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.aws2.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  zone_id         = "Z077919913NMEBCGB4WS0"
  ttl             = 60
  type            = each.value.type
  name            = each.value.name
  records         = [each.value.record]
  allow_overwrite = true
}

resource "aws_acm_certificate" "aws2" {
  domain_name       = "tfe3.anton.hashicorp-success.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "aws2" {
  certificate_arn = aws_acm_certificate.aws2.arn
}

resource "aws_lb_target_group" "aakulov-aws2" {
  name        = "aakulov-aws2"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "aakulov-aws2" {
  target_group_arn = aws_lb_target_group.aakulov-aws2.arn
  target_id        = aws_instance.aws2.id
  depends_on       = [aws_instance.aws2]
}

resource "aws_lb" "aws2" {
  name               = "aakulov-aws2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.aakulov-aws2.id]
  subnets            = [aws_subnet.subnet_private.id, aws_subnet.subnet_private1.id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "aws2" {
  load_balancer_arn = aws_lb.aws2.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate_validation.aws2.certificate_arn
  depends_on        = [aws_acm_certificate.aws2]
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aakulov-aws2.arn
  }
}

output "aws_url" {
  value       = aws_route53_record.aws2.name
  description = "Domain name of load balancer"
}