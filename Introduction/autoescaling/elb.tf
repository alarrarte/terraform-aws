resource "aws_security_group" "elb-sg" {
  name = "terraform-example-elb"
  vpc_id      = aws_vpc.main.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "asg-elb" {
  name = "asg-elb"
  security_groups = ["${aws_security_group.elb-sg.id}"]
  subnets = [ aws_subnet.private-a.id, aws_subnet.private-b.id]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}