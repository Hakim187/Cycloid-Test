Prerequisites

I set up a local Linux VM on my VMware, on which i set up my project, and installed Packer, ansible, docker and terraform

I set up AWS account and created new user with Access keys


What i have done : 


For this test, i used Packer along with Ansible provisioner to set up wordpress container connected to Rds database, and deployed on an AWS cloud provider

Steps of setting up :

1- Setting AWS infrastructure with Terraform :

First step was to implement the Aws infrastructure with its different components, with terraform as required,

to run the wordpress image, i used the ECS (elastic container service), a service that supports docker containers and allows to easily run and scale containerized
qpplications on AWS, and more specifically the AWS Fargate that allows to run containers without having to manage servers or clusters, 

Also i used RDS MariaDB as external database for my wordpress application, for which i created a specific username/password and DBname ,

How i deployed it ?

i created three terraform template files main.tf and variables.tf and output.tf

Variables.tf : to define the variables needed

Main.tf : the main file in which i wrote my code for the deployment of this components : 

IAM Role
IAM Policy
ECR Repository
ECS Cluster (Fargate)
ECS Task Definition
ECS Service
EC2 Security Groups
RDS MariaDB

and plus, i added an AWS access and AWS secret keys, that i generated from my AWS account


output.tf : for my output DB_endpoint


2- I set up a packer to create my wordpress image

i didn't use packer before, but let's say that wasn't quite complicated to provision docker image with wordpress application in it, and push it to the AWS 
ECR,

How i did it ?

I created aws_wordpress.json file , in which i defined my variables, 
i defined docker in the builders section , to build my image
and i defined, ansible in the provisionners section, with the ansible directory informations, to configure my docker image


3- I set up Ansible Roles :

for my container configuration , i used Ansible as tool to deploy certain components : 

Nginx
PHP-FPM
Wordpress App

every component is defined in an ansible role, with a common role file, for the RPM keys, and .repo files needed for the component installations



How I run my project:

After launching my packer command : packer buils aws_wordpress.json    the ECS service that was deployed via terraform will pick the latest image from ECR and run
the container, which i can display from my AWS ECR account, the wordpress app is using Nginx and php-fpm service, and the mariaDB as database, which is
running externally in AWS

Problems that i faced :

When i tried to deploy infrastructure, i faced errors related to my deployment parameters, then i realised that i didn't configure a vpc-id the subnets
(that i can pull from my aws account informations) , these two parmaters were important to deploy ecs service

Also When i tried to deploy my infrastructure, i faced errors related to a Amazon regional issue, which was eu-west-2, i had to change the region to us-east-1
to resolve this error, which is related to Amazon policies

For my nsible configuration, i faced errors related to Nginx and php deployment that were related to the docker not finding their packages when installing, 
so i added common role in ansible, to put my .repo files in the /etc/yum.repo.d/ and then install my components,


How would i do things to imporove?

i recommend to use AWS prameter store for better password handling , since passwords needs to be set manually everytime user need to set up passwords

i recommend to add monitoring solution such as Zabbix or Patrol
