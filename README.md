# terraform-aws-example
Example AWS infrastructure and app deployment using terraform.  
This repo contains terraform files which will create a Ubuntu 20.04 instance on AWS- along with associated network infrastructure- and deploy a simple Flask application (which can be found [here](https://github.com/agray998/QA-DevOps-Fundamental-Project)) on this VM, which can then be accessed on port 5000.  

In order to deploy this infrastructure, the following variables must be either set as environment variables with the prefix TF_VAR_ or, alternately, passed in at runtime using the -var option:
* accesskey - the access key for your AWS account
* secretkey - the secret key for your AWS account
* ubuntu_ami - An AMI for a Ubuntu EC2 instance
Once these variables are set, run the following commands:
```
terraform init  
terraform plan  
terraform apply
```