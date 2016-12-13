#!/usr/bin/env bash

if [ ! -f /home/vagrant/.initialized ]
  then
    if [ -f /vagrant/custom/initialize.sh ]
      then
        source /vagrant/custom/initialize.sh
    fi
    touch /home/vagrant/.initialized
fi    