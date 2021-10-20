resource "aws_instance" "example-vm-1" {
    ami           = "ami-0cef61fd3eb8cfb72"
    instance_type = "t2.micro"
}

resource "aws_network_interface" "demo-nic" {
  subnet_id       = var.sub-id
  private_ips     = ["10.0.1.50"]
  security_groups = [var.nsg-id]

  attachment {
    instance     = aws_instance.example-vm-1.id
    device_index = 1
  }
}