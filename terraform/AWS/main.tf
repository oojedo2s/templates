data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# data "aws_vpc" "default" {
#   id = "vpc-0562c7c26be620f17"
# }

resource "aws_vpc" "test_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  map_public_ip_on_launch = "true"
  cidr_block              = "172.16.0.0/24"
  tags = {
    Name = "test-subnet"
  }
}

resource "aws_internet_gateway" "test_ig" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "Test GW"
  }
}

resource "aws_route_table" "test_rt_table" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_ig.id
  }
  tags = {
    Name = "Test RT Table"
  }
}

resource "aws_route_table_association" "test_rt_table_association" {
  subnet_id      = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_rt_table.id
}

resource "aws_key_pair" "ssh_key" {
  public_key = file(var.key_path)
  key_name   = "SSH_Pub_key"
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    description = "ssh to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "test" {
  for_each = toset(var.instance_names)
  ami      = data.aws_ami.ubuntu.id #eu-central-1 (Frankfurt)
  #ami           = var.ami
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.test_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  key_name                    = aws_key_pair.ssh_key.key_name
  tags = {
    Name = each.value
    #Name = "TunsTest"
  }
}