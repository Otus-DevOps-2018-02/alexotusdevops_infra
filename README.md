# alexotusdevops_infra
alexotusdevops Infra repository

## Homework 4

Connect to someinternalhost in one-line command:
    ssh -i ~/.ssh/appuser -o "ProxyCommand ssh -W %h:%p appuser@35.204.199.104" appuser@10.164.0.3
Result:
    Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.13.0-1011-gcp x86_64)
    //...
    // bla bla bla
    //...
    Last login: Thu Mar 15 12:26:08 2018 from 10.164.0.2
    appuser@someinternalhost:~$

/////////////////////////////////////////////

Connect with "ssh someinternalhost" command:
    Edit ~/.ssh/config
    alex ~ % cat ~/.ssh/config
	Host bastion
	Hostname 35.204.199.104
	User appuser
	IdentityFile /home/alex/.ssh/appuser
    Host someinternalhost
	Hostname 10.164.0.3
	User appuser
	ProxyCommand ssh -W %h:%p bastion
	IdentityFile /home/alex/.ssh/appuser% 
Result:
    alex ~ % ssh someinternalhost
	Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.13.0-1011-gcp x86_64)
	//...
	// bla bla bla
	//...
	Last login: Thu Mar 15 12:27:17 2018 from 10.164.0.2
	appuser@someinternalhost:~$ 

/////////////////////////////////////////////

bastion_IP = 35.204.199.104
someinternalhost_IP = 10.164.0.3


## Homework 5

#### Create instance
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=/opt/Homework03.1/alexotusdevops_infra/startup_script.sh

#### Create firewall
gcloud compute --project=infra-198111 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server

testapp_IP = 35.204.199.104
testapp_port = 9292

## Homework 6

Configuration files ubuntu1604.json & immutable.json created
Create image for manual deploy virtual machine from google cloud console
Create script for silent deploy virtual machine

## Homework 7

#### Main task

Add terraform directory
Create config files for terraform
Apply terraform config to deploy app

#### Task *

Add ssh key for several users

Problem: do not use web console to manage ssh keys when terraform exist

#### Task **

Edit terraform config to deploy several apps
Create terraform config to deploy load balancer

