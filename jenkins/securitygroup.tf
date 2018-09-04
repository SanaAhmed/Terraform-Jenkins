resource "aws_security_group" "jenkins_security_group" {
  vpc_id      = "${aws_vpc.jenkins_vpc.id}"
  name        = "Jenkins_Security_Group"
  description = "Managed By Terraform"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "jenkins-security-group"
    ManagedBy = "Terraform"
  }
}
