resource "aws_instance" "example_vm_1" {
    ami           = "ami-0cef61fd3eb8cfb72"
    instance_type = "t2.micro"
    key_name = "terrakeys"
    availability_zone = "eu-west-2a"

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