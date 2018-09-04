resource "aws_vpc" "jenkins_vpc" {
  cidr_block = "10.10.0.0/16"

  tags {
    Name = "jenkins-vpc"
    ManagedBy = "Terraform"
  }
}

resource "aws_internet_gateway" "jenkins_internet_gateway" {
  vpc_id = "${aws_vpc.jenkins_vpc.id}"

  tags {
    Name = "jenkins-internet-gateway"
    ManagedBy = "Terraform"
  }
}

resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.jenkins_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.jenkins_internet_gateway.id}"
}

resource "aws_subnet" "public" {
  count = "${length(split(",",var.zone))}"
  vpc_id = "${aws_vpc.jenkins_vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.jenkins_vpc.cidr_block, 8, count.index+1)}"
  map_public_ip_on_launch = true
  availability_zone = "${element(split(",",var.zone), count.index)}"

  tags {
    Name = "jenkins-subnet"
    ManagedBy = "Terraform"
  }
}