#!/bin/bash

set -ex

sudo apt-get update
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get install ansible -y
cd /tmp
unzip -o ansible.zip
cd /tmp/ansible
ansible-playbook -b -l localhost -i inventory/local.dev playbooks/docker.yml --connection=local
ansible-playbook -b -l localhost -i inventory/local.dev playbooks/jenkins-slave.yml --connection=local