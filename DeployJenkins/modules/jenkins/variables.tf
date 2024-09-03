

variable "instance" {
  type = map(object({
    name = string
    instance_type = string
    ami = string
    key_name = string
    user_data = string
  }))
  default = {
    "mmo-jenkins" = {
        name = "mmo-jenkins"
        instance_type = "t2.large"
        ami = "ami-04a81a99f5ec58529"
        key_name = "tfkey"
        user_data = <<-EOL
            #!/bin/bash -xe 
            sudo apt update
            sudo apt install fontconfig openjdk-17-jre -y
            apt install software-properties-common gnupg -y
            sudo add-apt-repository --yes --update ppa:ansible/ansible
            apt install ansible -y
            sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
            https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
            echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
            https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
            /etc/apt/sources.list.d/jenkins.list > /dev/null
            sudo apt-get update
            sudo apt-get install jenkins -y
            wget -O- https://apt.releases.hashicorp.com/gpg | \
            gpg --dearmor | \
            sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
            https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
            sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt update
            sudo apt-get install terraform unzip
            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
            unzip awscliv2.zip
            sudo ./aws/install
            mkdir /home/Client
            echo "jenkins ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers



            EOL
    }
    "mmo-squid" = {
        name = "mmo-squid"
        instance_type = "t2.large"
        ami = "ami-04a81a99f5ec58529"
        key_name = "tfkey"
        user_data = <<-EOL
            sudo apt update && apt install squid -y

        EOL
    }
  }
}

variable "region" {}