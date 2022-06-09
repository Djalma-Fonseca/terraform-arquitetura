

# Security group para acesso remoto ssh
resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"
  vpc_id = aws_vpc.vpc-lab.id

ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
 }
}

# Security group para acesso http
resource "aws_security_group" "acesso-http" {
  name        = "acesso-http"
  description = "acesso-http"
  vpc_id = aws_vpc.vpc-lab.id



  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
} 

# Security group para acesso https
resource "aws_security_group" "acesso-https" {
  name        = "acesso-https"
  description = "acesso-https"
  vpc_id = aws_vpc.vpc-lab.id



  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
} 