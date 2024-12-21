locals {
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnets[0]
  name_prefix      = "harris"
}

resource "aws_instance" "public" {
  ami                         = "ami-04c913012f8977029"
  instance_type               = "t2.micro"
  subnet_id                   = local.public_subnet_id
  associate_public_ip_address = true
  key_name                    = "${local.name_prefix}-key-pair" #Change to your keyname, e.g. jazeel-key-pair
  vpc_security_group_ids      = [aws_security_group.dynamodb_reader.id]
  iam_instance_profile        = aws_iam_instance_profile.profile_dynamodb.id

  tags = {
    Name = "${local.name_prefix}-dynamodb-reader" #Prefix your own name, e.g. jazeel-ec2
  }
}

output "public_ip" {
  value = aws_instance.public.public_ip
}

output "public_dns" {
  value = aws_instance.public.public_dns
}