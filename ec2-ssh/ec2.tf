# 最新のAmazonLinux2 AMI
data "aws_ami" "latest_amzn2_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "this" {
  ami = data.aws_ami.latest_amzn2_ami.id

  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.this.id]

  subnet_id = aws_subnet.public.id

}

output "public_ip" {
  value = aws_instance.this.public_ip
}
