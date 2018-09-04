# Terraform Script for Jenkins

1) terraform init

2) Provide AWS Access Key and AWS Secret Key in variables file

3) terraform plan

3) terraform apply

The above commands will provision two ec2 instance and on fly it the provisioner script
will be executed which are zipped in scripts/ansible.zip folder

"ansible" contains;
   1) Deployment of Jenkins Master on ec2 instance will be done by initializer_jenkins_master.sh
   2) Deployment of Jenkins Slave on ec2 instance will be done by initializer_slave.sh
