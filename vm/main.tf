resource "aws_instance" "example_vm_1" {
    ami               = var.vm_ami
    instance_type     = "t2.micro"
    key_name          = "terrakeys"
    availability_zone = "eu-west-2a"
    user_data         = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt install python3 python3-pip -y
    git clone https://github.com/agray998/QA-DevOps-Fundamental-Project.git && cd QA-DevOps-Fundamental-Project
    pip3 install -r requirements.txt
    export secretkey=jwbcjwbvbvwdvbwqjebvkwebvq
    python3 create.py
    gunicorn -D --workers=4 --bind=0.0.0.0:5000 app:app
    EOF


    network_interface {
      device_index         = 0
      network_interface_id = aws_network_interface.demo_nic.id
    }
}

resource "aws_network_interface" "demo_nic" {
  subnet_id       = var.sub_id
  private_ips     = ["10.0.1.50"]
  security_groups = [var.nsg_id]
}