#!/bin/bash

if [ ! -f /home/vagrant/shared_folder/id_rsa ]; then
    ssh-keygen -t rsa -b 2048 -f /home/vagrant/shared_folder/id_rsa -q -N ""
fi

echo "Host server" >> /home/vagrant/.ssh/config
echo "    HostName 192.168.56.102" >> /home/vagrant/.ssh/config
echo "    User vagrant" >> /home/vagrant/.ssh/config
echo "    IdentityFile /home/vagrant/shared_folder/id_rsa" >> /home/vagrant/.ssh/config