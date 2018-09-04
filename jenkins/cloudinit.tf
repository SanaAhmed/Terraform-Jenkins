data "template_file" "shell-script" {
  template = "${file("scripts/initializer_jenkins_master.sh")}"
}

data "template_file" "jenkinsSlave-script" {
  template = "${file("scripts/initializer_slave.sh")}"
}

data "template_cloudinit_config" "cloudinit-ansible" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.shell-script.rendered}"
  }
}

data "template_cloudinit_config" "cloudinit-jenkinsSlave" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkinsSlave-script.rendered}"
  }
}
