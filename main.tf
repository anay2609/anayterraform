resource "aws_vpc" "main" {

cidr_block="10.0.0.0/16"

enable_dns_support=true

enable_dns_hostnames=true

tags={

Name="terraform-vpc"

}

}
resource "aws_internet_gateway" "igw" {

vpc_id=aws_vpc.main.id

}
resource "aws_subnet" "public1" {

vpc_id=aws_vpc.main.id

cidr_block="10.0.1.0/24"

availability_zone="ap-south-1a"

map_public_ip_on_launch=true

}
resource "aws_subnet" "public2" {

vpc_id=aws_vpc.main.id

cidr_block="10.0.2.0/24"

availability_zone="ap-south-1b"

map_public_ip_on_launch=true

}
resource "aws_route_table" "public" {

vpc_id=aws_vpc.main.id

route {

cidr_block="0.0.0.0/0"

gateway_id=aws_internet_gateway.igw.id

}

}
resource "aws_route_table_association" "a1" {

subnet_id=aws_subnet.public1.id

route_table_id=aws_route_table.public.id

}

resource "aws_route_table_association" "a2" {

subnet_id=aws_subnet.public2.id

route_table_id=aws_route_table.public.id

}
resource "aws_network_acl" "main" {

vpc_id=aws_vpc.main.id

subnet_ids=[

aws_subnet.public1.id,

aws_subnet.public2.id

]

ingress {

rule_no=100

protocol="tcp"

action="allow"

cidr_block="0.0.0.0/0"

from_port=22

to_port=22

}

egress {

rule_no=100

protocol="-1"

action="allow"

cidr_block="0.0.0.0/0"

from_port=0

to_port=0

}

}
resource "aws_security_group" "sg" {

name="terraform-sg"

vpc_id=aws_vpc.main.id

ingress {

from_port=22

to_port=22

protocol="tcp"

cidr_blocks=["0.0.0.0/0"]

}

ingress {

from_port=80

to_port=80

protocol="tcp"

cidr_blocks=["0.0.0.0/0"]

}

ingress {

from_port=-1
to_port=-1

protocol="icmp"

cidr_blocks=["0.0.0.0/0"]

}

egress {

from_port=0

to_port=0

protocol="-1"

cidr_blocks=["0.0.0.0/0"]

}

}
resource "aws_instance" "ubuntu" {

for_each=var.vms

ami="ami-0388e3ada3d9812da"

instance_type=each.value

key_name="terraform-key"

subnet_id=aws_subnet.public1.id

vpc_security_group_ids=[

aws_security_group.sg.id

]

root_block_device {

volume_size=10

}

tags={

Name=each.key

}

}

