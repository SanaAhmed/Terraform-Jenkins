provider "aws" {
  region = "${var.AWS_REGION}"
  profile = "default"
}

resource "aws_instance" "jenkins_master" {
  ami                    = "${lookup(var.amis, var.AWS_REGION)}"
  instance_type          = "${var.instance_type}"
  key_name               = "Careem-Servers.pem"
  user_data              = "${data.template_cloudinit_config.cloudinit-ansible.rendered}"
  vpc_security_group_ids = ["${aws_security_group.jenkins_security_group.id}"]
  subnet_id = "${element(aws_subnet.public.*.id, 0)}"
  associate_public_ip_address = false

  connection {
    type        = "ssh"
    user        = "${var.instance_username}"
    host        = "${aws_instance.jenkins_master.private_ip}"
    agent       = false
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

  provisioner "file" {
    source      = "scripts/ansible.zip"
    destination = "/tmp/ansible.zip"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags {
    Name = "jenkins-master-instance"
    ManagedBy = "Terraform"
  }
}


resource "aws_instance" "jenkins_slave" {
  ami                    = "${lookup(var.amis, var.AWS_REGION)}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.Jenkins_key.key_name}"
  user_data              = "${data.template_cloudinit_config.cloudinit-jenkinsSlave.rendered}"
  vpc_security_group_ids = ["${aws_security_group.jenkins_security_group.id}"]
  subnet_id = "${element(aws_subnet.public.*.id, 0)}"
  availability_zone      = "${var.zone}"
  associate_public_ip_address = false

  connection {
    type        = "ssh"
    user        = "${var.instance_username}"
    host        = "${aws_instance.jenkins_master.private_ip}"
    agent       = false
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

  provisioner "file" {
    source      = "scripts/ansible.zip"
    destination = "/tmp/ansible.zip"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = false
  }

  tags {
    Name = "jenkins-slave-instance"
    ManagedBy = "Terraform"
  }
}