#!/bin/sh

############################################################
#
# Installs the [berkshelf](http://berkshelf.com/) cookbook
# management plugin and initialize Vagrant.
#
############################################################

# Install [berkshelf](http://berkshelf.com/) if it isnt installed already
which berks > /dev/null || gem install berkshelf

# Install the berkshelf plugin (for Vagrant 1.1.0 and greater)
vagrant plugin install vagrant-berkshelf

# Initialize the Vagrant vm
vagrant up