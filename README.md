# alexotusdevops_infra
alexotusdevops Infra repository

##### [Homework 4](#hw4) 
 * [Connect in one-line command](#hw41)  
 * [Connect with "ssh someinternalhost" command](#hw42) 
 * [IP list](#hw43) 
##### [Homework 5](#hw5) 
 * [Create instance](#hw51)  
 * [Create firewall](#hw52)  
 * [IP list](#hw53) 
##### [Homework 6](#hw6)  
##### [Homework 7](#hw7)  
 * [Main task](#hw71)  
 * [Task \*](#hw72)  
 * [Task \**](#hw73)  
##### [Homework 8](#hw8)  
 * [Main task](#hw81)  
 * [Task \*](#hw82)  
##### [Homework 9](#hw9)  
 * [Main task](#hw91)  
 * [Task \*](#hw92)  

<a name="hw4"></a>
## Homework 4
<a name="hw41"></a>
##### Connect to someinternalhost in one-line command:
> ssh -i ~/.ssh/appuser -o "ProxyCommand ssh -W %h:%p appuser@35.204.199.104" appuser@10.164.0.3
> > 
Result:
>    Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.13.0-1011-gcp x86_64)  
    //...  
    // bla bla bla  
    //...  
    Last login: Thu Mar 15 12:26:08 2018 from 10.164.0.2  
    appuser@someinternalhost:~$  
>

<a name="hw42"></a>
##### Connect with "ssh someinternalhost" command:
Edit ~/.ssh/config  
> alex ~ % cat ~/.ssh/config  
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

>    alex ~ % ssh someinternalhost  
    Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.13.0-1011-gcp x86_64)  
    //...  
    // bla bla bla  
    //...  
    Last login: Thu Mar 15 12:27:17 2018 from 10.164.0.2  
    appuser@someinternalhost:~$   


<a name="hw43"></a>
bastion_IP = 35.204.199.104  
someinternalhost_IP = 10.164.0.3

<a name="hw5"></a>
## Homework 5
<a name="hw51"></a>
##### Create instance
> gcloud compute instances create reddit-app\  
--boot-disk-size=10GB \  
--image-family ubuntu-1604-lts \  
--image-project=ubuntu-os-cloud \  
--machine-type=g1-small \  
--tags puma-server \  
--restart-on-failure \  
--metadata-from-file startup-script=/opt/Homework03.1/alexotusdevops_infra/startup_script.sh  
<a name="hw52"></a>
##### Create firewall
> gcloud compute --project=infra-198111 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
<a name="hw53"></a>
testapp_IP = 35.204.199.104  
testapp_port = 9292

<a name="hw6"></a>
## Homework 6

 - Configuration files ubuntu1604.json & immutable.json created  
 - Create image for manual deploy virtual machine from google cloud console  
 - Create script for silent deploy virtual machine  

<a name="hw7"></a>
## Homework 7
<a name="hw71"></a>
##### Main task

 - Add terraform directory  
 - Create config files for terraform  
 - Apply terraform config to deploy app   
<a name="hw72"></a>
##### Task *

 - Add ssh key for several users  
 - Problem: do not use web console to manage ssh keys when terraform exist  
<a name="hw73"></a>
##### Task **

 - Edit terraform config to deploy several apps  
 - Create terraform config to deploy load balancer  

<a name="hw8"></a>
## Homework 8
<a name="hw81"></a>
##### Main task
 - Import Google Infrastructure to terraform
 - Split project into modules
 - Add VPC module
 - Create Stage & Prod env
 - Create FW rules for external IP
 - Del old files
<a name="hw82"></a>
##### Task *
 - Storage-bucket created
 - Setting up remote backend

<a name="hw9"></a>
## Homework 9
<a name="hw91"></a>
##### Main task
 - Install ansible
 - Play with ansible
 - Create simple ansible playbook
> ansible-playbook clone.yml

appserver: ok=2 changed=0 unreachable=0 failed=0
> ansible app -m command -a 'rm -rf ~/reddit'
> ansible-playbook clone.yml

appserver: ok=2 changed=1 unreachable=0 failed=0

В первом случае плейбук применился, но ничего не изменил, т.к. директория ~/reddit уже существовала

<a name="hw92"></a>
##### Task *
 - Create Inventory.json 

