
# Criação do load balance para as duas subnets privadas
resource "aws_lb" "balance-lab" {
  name               = "lab-teste-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.acesso-http.id}"]
  subnets            = ["${aws_subnet.private_subnet_1.id}", "${aws_subnet.private_subnet_2.id}"]
  

  enable_deletion_protection = true
}