# Criando primeira instância
resource "aws_instance" "dev-lab-1" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  subnet_id = aws_subnet.private_subnet_1.id


  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF
  
  tags = {
    Name = "Dev-lab-1"
 }

  vpc_security_group_ids = [aws_security_group.acesso-ssh.id, aws_security_group.acesso-http.id, aws_security_group.acesso-https.id]

  
}

# Criando segunda instância
 resource "aws_instance" "dev-lab-2" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  subnet_id = aws_subnet.private_subnet_2.id
  
  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF
  
  tags = {
    Name = "Dev-lab-2"
 }

  vpc_security_group_ids = [aws_security_group.acesso-ssh.id, aws_security_group.acesso-http.id, aws_security_group.acesso-https.id]

}

 # Criando instância mysql
 resource "aws_db_instance" "banco" {
  allocated_storage = 10
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t2.micro"
  db_name           = "aula"
  username          = "admin"
  password          = "admin12345"
  skip_final_snapshot = true
  
  db_subnet_group_name = aws_db_subnet_group.db_subnet.id
}

  

resource "aws_db_subnet_group" "db_subnet" {
    name = "dbsubnet"
    subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}



