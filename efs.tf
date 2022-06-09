

# Criando EFS
resource "aws_efs_file_system" "wordpress-efs-lab" {
  creation_token = "wordpress-efs"

  tags = {
    Name = "wordpress-efs-lab"
  }
}


# Associando EFS com as duas subnets privadas
resource "aws_efs_mount_target" "wordpress-efs-lab-target" {
  file_system_id = "${aws_efs_file_system.wordpress-efs-lab.id}"
  subnet_id      = "${aws_subnet.private_subnet_1.id}"
  
  security_groups = ["${aws_security_group.acesso-http.id}"]
}

resource "aws_efs_mount_target" "wordpress-efs-lab-target-2" {
  file_system_id = "${aws_efs_file_system.wordpress-efs-lab.id}"
  subnet_id      = "${aws_subnet.private_subnet_2.id}"
  
  security_groups = ["${aws_security_group.acesso-http.id}"]
}