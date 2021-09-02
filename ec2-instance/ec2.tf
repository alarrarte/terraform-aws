resource "aws_instance" "example-instance" {
    ami                 = "ami-0c2b8ca1dad447f8a"
    instance_type       = "t2.micro"
    subnet_id           = aws_subnet.private-a.id


    tags = {
        Name = "TF-EC2-Example"
    }
}