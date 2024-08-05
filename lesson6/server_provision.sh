#!/bin/bash

mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
cat /home/vagrant/shared_folder/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys