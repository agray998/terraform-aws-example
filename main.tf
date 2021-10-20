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
    source   = "./vpc"
}

module "vm_module" {
    source = "./vm"
    nsg_id = module.vpc_module.nsg_id
    sub_id = module.vpc_module.sub_id
}