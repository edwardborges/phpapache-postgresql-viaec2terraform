resource "aws_instance" "example" {
  ami                    = "ami-0c65adc9a5c1b5d7c" # ID da AMI apropriada para a região escolhida Ubuntu, melhor pra teste
  instance_type          = "t2.micro"              # Tipo de instância desejado
  key_name               = "testeiac"              # Nome do seu Key Pair
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data                   = <<-EOT
    ${file("./userdata.sh")}
  EOT
  user_data_replace_on_change = true

  tags = {
    Name = "ec2-instance-example"
  }
}
