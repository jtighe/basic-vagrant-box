# Basic Vagrant Box  - LAMP - Virtual Machine
A basic Vagrant Development Environment to use as a starting place.

This is a pretty bare bones implementation that allows for further customization.There are a couple of nice features included:
- It will automatically set up your git account(s)
- It will install either PHP5 or PHP7
- Allows for custom provisioning
- Allows for custom initialization after setup
- Allows for NFS on Windows

Two directories will be synced to the Virtual Machine.
```
/wwwLogs
/wwwSites
```
## Prerequisites

Make sure you have [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/) installed.

Additionally, if you are on a windows machine you need [Vagrant WinNFSd](https://github.com/winnfsd/vagrant-winnfsd) and [Vagrant Bindfs](https://github.com/gael-ian/vagrant-bindfs)

These can be installed by issuing the following at your prompt:
```
$ vagrant plugin install vagrant-winnfsd
$ vagrant plugin install vagrant-bindfs
```
If your computer cannot handle NFS, you can comment out the NFS syncing and use the vagrant defaults:
```
  # Setup shared folders
  config.vm.synced_folder "./wwwSites", "/var/www", :group => "www-data", :mount_options => ['dmode=775','fmode=664']

  #config.vm.synced_folder "./wwwSites", "/var/www", type: :nfs
  #config.bindfs.bind_folder "/var/www", "/var/www"
```
    
## Configuration
1. Vagrantfile
	- Set PHP Version
	- Set Name of this instance
	- Set number of CPU's
	- Set amount of memory
2. **Copy** your Private ssh Key(s) to your project root.
3. Config.sh
	- Set Name
    - Set email address
	- for each git server add:
		-  your user name
		-  the name of you private key file (**id_rsa** for example) for this git server.
			- if you use the same key for multiple servers just list it, it will be copied only once. 
	- add multiple servers if necessary.

## Usage
First time Startup (can take a bit of time, bear with it):
```
$ vagrant up --provision
```
To shutdown (you won't lose anything):
```
$ vagrant halt
```
To start it back up:
```
$ vagrant up
```
To SSH into the VM:
```
$ vagrant ssh
```
## Customization
If you want to customize the virtual machine, there are two files you can edit.
```
/custom/provision.sh
/custom/initialize.sh
```
The ** provision.sh** script is included right after the basic provisioning has completed and has access to all the vars in the config.sh file.

The **initialize.sh** script is included after you ssh in and issue the 'initialize' command. You can include the config.sh file if you need access to the vars.

## Initialization
To initialize your vagrant box:
```
$ vagrant ssh
$ vagrant initialize
```
 You can include the config.sh file if you need access to the vars.
```
source /vagrant/config.sh
```
If you need to know the php version you can check the .php flag.
```
if [ -f /home/vagrant/.php5 ]
  then
    # PHP5
  else
    # PHP7
fi
```

## Notes

## Change Log






