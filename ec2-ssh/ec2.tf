variable "key_name" {
  type    = string
  default = "ec2_key"
}

# 最新のAmazonLinux2のイメージ
data "aws_ami" "latest_amzn2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file("${var.key_name}.pub")
}

resource "aws_instance" "this" {
  ami = data.aws_ami.latest_amzn2.id

  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.this.id]

  subnet_id = aws_subnet.public.id

  key_name = aws_key_pair.this.key_name
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "ssh_command" {
  value = "ssh -i ${var.key_name} ec2-user@${aws_instance.this.public_ip}"
}
