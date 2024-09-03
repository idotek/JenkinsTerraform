locals {
  Subnet = {
    TO_CHANGE-Admin-Machine = aws_subnet.SimpleLB-Subnets["Public-Subnet"].id
    TO_CHANGE-AZ-A-Machine  = aws_subnet.SimpleLB-Subnets["AZ-A"].id
    TO_CHANGE-AZ-B-Machine  = aws_subnet.SimpleLB-Subnets["AZ-B"].id
    TO_CHANGE-AZ-C-Machine  = aws_subnet.SimpleLB-Subnets["AZ-C"].id

  }
  Security_group = {
    TO_CHANGE-Admin-Machine = aws_security_group.AdminNSG.id
    TO_CHANGE-AZ-A-Machine  = aws_security_group.WebNSG.id
    TO_CHANGE-AZ-B-Machine  = aws_security_group.WebNSG.id
    TO_CHANGE-AZ-C-Machine  = aws_security_group.WebNSG.id

  }

}

variable "VPC" {
  default =   "TO_CHANGE"
}

variable "VPC-Subnet" {
  default = "10.XXX.0.0/16"
  
}

variable "route_table_name" {
  default = "TO_CHANGE-RouteTable"
}

variable "Subnet" {
  type = map(object({
    name                    = string
    cidr_block              = string
    region                  = string
    map_public_ip_on_launch = bool

  }))
  default = {
    "Public-Subnet" = {
      name                    = "TO_CHANGE-Public-Subnet"
      cidr_block              = "10.XXX.1.0/24"
      region                  = "us-east-1a"
      map_public_ip_on_launch = true
    }
    "AZ-A" = {
      name                    = "TO_CHANGE-AZ-A"
      cidr_block              = "10.XXX.2.0/24"
      region                  = "us-east-1a"
      map_public_ip_on_launch = true
    }
    "AZ-B" = {
      name                    = "TO_CHANGE-AZ-B"
      cidr_block              = "10.XXX.3.0/24"
      region                  = "us-east-1b"
      map_public_ip_on_launch = true
    }
    "AZ-C" = {
      name                    = "TO_CHANGE-AZ-C"
      cidr_block              = "10.XXX.4.0/24"
      region                  = "us-east-1c"
      map_public_ip_on_launch = true
    }
  }
}

variable "lb_name" {
  default = "TO_CHANGE-LB"
  
}

variable "instances" {
  type = map(object({
    name          = string
    instance_type = string
    ami           = string
    key_name      = string
    command       = string
  }))
  default = {
    "Admin-Machine" = {
      name          = "TO_CHANGE-Admin-Machine"
      instance_type = "t2.micro"
      ami           = "ami-0e86e20dae9224db8"
      key_name      = "admin"
      command       = <<-EOL
      #!/bin/bash -xe 
      sudo apt update
      EOL
    }
    "AZ-A-Machine" = {
      name          = "TO_CHANGE-AZ-A-Machine"
      instance_type = "t2.micro"
      ami           = "ami-0e86e20dae9224db8"
      key_name      = "prod"
      command       = <<-EOL
      #!/bin/bash -xe 
      sudo apt update 
      sudo apt install apache2 -y 
      echo $(cat /etc/hostname) | sudo tee /var/www/html/index.html 
      EOL
    }
    "AZ-B-Machine" = {
      name          = "TO_CHANGE-AZ-B-Machine"
      instance_type = "t2.micro"
      ami           = "ami-0e86e20dae9224db8"
      key_name      = "prod"
      command       = <<-EOL
      #!/bin/bash -xe 
      sudo apt update 
      apt install apache2 -y 
      echo $(cat /etc/hostname) | sudo tee /var/www/html/index.html
      EOL
    }
    "AZ-C-Machine" = {
      name          = "TO_CHANGE-AZ-C-Machine"
      instance_type = "t2.micro"
      ami           = "ami-0e86e20dae9224db8"
      key_name      = "prod"
      command       = <<-EOL
      #!/bin/bash -xe 
      sudo apt update 
      sudo apt install apache2 -y 
      echo $(cat /etc/hostname) | sudo tee /var/www/html/index.html
      EOL
    }


  }
}

 