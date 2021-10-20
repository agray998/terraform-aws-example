terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 2.0"
        }
    }
}

provider "aws" {
    access_key = var.accesskey
    secret_key = var.secretkey
    region     = "eu-west-2"
}

module "vpc_module" {
    source = "./vpc"
    vpc-cidr = "10.0.0.0/16"
}

module "vm_module" {
    source = "./vm"
    vpc-id = module.vpc_module.vpc_id
    nsg-id = module.vpc_module.nsg_id
    sub-id = module.vpc_module.sub_id
}